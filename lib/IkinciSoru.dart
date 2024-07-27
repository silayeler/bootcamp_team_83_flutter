import 'package:bootcamp_team_83_flutter/ucuncu.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class IkinciSoru extends StatefulWidget {
  const IkinciSoru({super.key});

  @override
  _IkinciSoruState createState() => _IkinciSoruState();
}

class _IkinciSoruState extends State<IkinciSoru> {
  late Future<void> _questionDataFuture;
  final int _currentQuestionIndex = 2; // Başlangıçta 1. sorudayız
  final int _totalQuestions = 3;
  String question = "";
  List<String> options = [];
  String correctAnswer = "";
  String selectedOption = "";
  bool isCorrect = false;
  bool showMessage = false;

  @override
  void initState() {
    super.initState();
    _questionDataFuture = fetchQuestionAndAnswers();
  }

  Future<void> fetchQuestionAndAnswers() async {
    try {
      DocumentSnapshot questionSnapshot = await FirebaseFirestore.instance
          .collection('questions')
          .doc('Questions3') // Doküman ismi soru numarasına göre değişecek
          .get();

      if (questionSnapshot.exists) {
        setState(() {
          question = questionSnapshot['question'] ?? "";
          options = List<String>.from(questionSnapshot['option'] ?? []);
          correctAnswer = questionSnapshot['correct_answer'] ?? "";
        });

        print('Fetched data: $question, $options, $correctAnswer');
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching question: $e');
    }
  }

  void checkAnswer(String option) {
    setState(() {
      selectedOption = option;
      if (option == correctAnswer) {
        isCorrect = true;
        _showCongratulationsDialog();
      } else {
        isCorrect = false;
        showMessage = true;
        _showWrongAnswerDialog();
      }
    });
  }

  void _showCongratulationsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 400,
                height: 270,
                child: Image.asset(
                  'images/tebrikler.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Devam', style: TextStyle(fontSize: 20)),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Ucuncu()), // Bu satırı güncelleyin
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showWrongAnswerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 400,
                height: 270,
                child: Image.asset(
                  'images/tekrardene.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Devam', style: TextStyle(fontSize: 20)),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _questionDataFuture = fetchQuestionAndAnswers();
                });
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: constraints.maxWidth * (_currentQuestionIndex / _totalQuestions),
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                },
              ),
              const Positioned(
                right: 0,
                child: Icon(
                  Icons.bolt,
                  color: Colors.yellow,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Soru $_currentQuestionIndex / $_totalQuestions',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/arkaplan.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 120),
            _buildProgressBar(),
            Expanded(
              child: FutureBuilder<void>(
                future: _questionDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading question'));
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          isCorrect ? '"$correctAnswer" $question' : '_______ $question',
                          style: const TextStyle(fontSize: 25),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        Wrap(
                          spacing: 10,
                          children: options.map((option) {
                            return ElevatedButton(
                              onPressed: () => checkAnswer(option),
                              child: Text(option),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


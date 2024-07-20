import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Ucuncu extends StatefulWidget {
  @override
  _UcuncuState createState() => _UcuncuState();
}

class _UcuncuState extends State<Ucuncu> {
  late Future<Map<String, dynamic>> _questionDataFuture;
  String _correctAnswer = '';
  String _selectedAnswer = '';
  int _currentQuestionIndex = 3; // Başlangıçta 1. sorudayız
  final int _totalQuestions = 3; // Toplam 10 soru var

  @override
  void initState() {
    super.initState();
    _questionDataFuture = fetchQuestionData(_currentQuestionIndex);
  }

  Future<Map<String, dynamic>> fetchQuestionData(int index) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('questions')
        .doc('Quesitons') // Soru dokümanının ID'si
        .get();
    var data = doc.data() as Map<String, dynamic>;
    setState(() {
      _correctAnswer = data['correct_answer'];
    });
    return data;
  }

  void _goToNextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _totalQuestions) {
        _currentQuestionIndex++;
        _questionDataFuture = fetchQuestionData(_currentQuestionIndex); // Yeni soru verilerini yükle
      } else {
        // Son soruya geldiyse yapılacak işlemler
      /*  Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IkinciSorusu()), // Sonuç sayfasına yönlendirme
        );*/
      }
    });
  }

  void checkAnswer(String option) {
    setState(() {
      _selectedAnswer = option;
      if (option == _correctAnswer) {
        _showCongratulationsDialog();
      } else {
        _showWrongAnswerDialog();
      }
    });
  }

  void _showCongratulationsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
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
              child: Text('Devam', style: TextStyle(fontSize: 20)),
              onPressed: () {
                Navigator.of(context).pop(); // Diyaloğu kapat
               /* Navigator.push(
                 // context,
                //  MaterialPageRoute(builder: (context) => IkinciSorusu()), // Doğru cevaptan sonra IkinciSorusu sayfasına geçiş
                );*/
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
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
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
              child: Text('Devam', style: TextStyle(fontSize: 20)),
              onPressed: () {
                Navigator.of(context).pop(); // Diyaloğu kapat
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildButton(String text) {
    bool isSelected = text == _selectedAnswer;
    bool isCorrect = isSelected && text == _correctAnswer;
    Color buttonColor = isSelected
        ? (isCorrect ? Colors.green : Colors.red)
        : Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        width: 270,
        height: 80,
        child: ElevatedButton(
          onPressed: () {
            checkAnswer(text); // Seçilen cevabı kontrol et
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 4),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: _questionDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Veri bulunamadı.'));
          } else {
            var data = snapshot.data!;
            var question = data['question'] ?? 'Soru bulunamadı';
            var options = List<String>.from(data['options'] ?? []);

            return Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'images/arkaplan.png',
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 20, // Yukarıya taşımak için değeri azaltın
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.black),
                            iconSize: 40,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      // İlerleme çubuğu
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Stack(
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
                                  width: constraints.maxWidth *
                                      (_currentQuestionIndex / _totalQuestions),
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                );
                              },
                            ),
                            Positioned(
                              right: 0,
                              child: Icon(
                                Icons.bolt, // Şimşek ikonu
                                color: Colors.yellow,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Soru $_currentQuestionIndex / $_totalQuestions',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 300,
                        height: 200,
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black, width: 4),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              question,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          ...options.map((option) => buildButton(option)).toList(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

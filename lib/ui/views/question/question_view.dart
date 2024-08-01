import 'package:bootcamp_team_83_flutter/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'question_viewmodel.dart';

class QuestionView extends StackedView<QuestionViewModel> {
  final List<Map<String, dynamic>> questions;

  const QuestionView({Key? key, required this.questions}) : super(key: key);

  @override
  Widget builder(BuildContext context, QuestionViewModel viewModel, Widget? child) {
    return Scaffold(
      body: PageView.builder(
        itemCount: questions.length,
        controller: PageController(initialPage: viewModel.currentQuestionIndex),
        physics: NeverScrollableScrollPhysics(), // Kaydırmayı devre dışı bırak
        itemBuilder: (context, index) {
          var questionData = questions[index];
          return Stack(
            children: [
              Container(
                width: screenWidth(context),
                height: screenHeight(context),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/sorusayfasi_arkaplani.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if(questionData['questionType']=='multiple_choice' ||questionData['questionType']=='fill_in_blank')
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Soru ${index + 1}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),

                              Text(
                                questionData['question'],
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildQuestionContent(context, questionData, viewModel),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildQuestionContent(BuildContext context, Map<String, dynamic> questionData, QuestionViewModel viewModel) {
    switch (questionData['questionType']) {
      case 'multiple_choice':
        return _buildMultipleChoiceQuestion(context, questionData, viewModel);
      case 'fill_in_blank':
        return _buildFillInBlankQuestion(context, questionData, viewModel);
      case 'coding':
        return _buildCodingQuestion(context, questionData, viewModel);
      default:
        return Text('Bilinmeyen soru tipi: ${questionData['questionType']}');
    }
  }

  Widget _buildMultipleChoiceQuestion(BuildContext context, Map<String, dynamic> questionData, QuestionViewModel viewModel) {
    return Column(
      children: [
        ...['optionA', 'optionB', 'optionC', 'optionD'].map((option) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                viewModel.selectOption(questionData[option]);
                _checkAndProceed(viewModel, context);
              },
              style: ElevatedButton.styleFrom(
                maximumSize: Size(150, 300),
                backgroundColor: viewModel.selectedOption == questionData[option]
                    ? Colors.blueAccent
                    : Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                questionData[option],
                style: TextStyle(
                  color: viewModel.selectedOption == questionData[option]
                      ? Colors.white
                      : Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildFillInBlankQuestion(BuildContext context, Map<String, dynamic> questionData, QuestionViewModel viewModel) {
    List<String> parts = questionData['question'].split('___');
    return Column(
      children: [
        for (int i = 0; i < parts.length; i++) ...[
          Text(parts[i], style: TextStyle(fontSize: 18)),
          if (i < parts.length - 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Boşluğu doldurun',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => viewModel.updateBlankAnswer(i, value),
              ),
            ),
        ],
        ElevatedButton(
          onPressed: () => _checkAndProceed(viewModel, context),
          child: Text('Kontrol Et'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildCodingQuestion(BuildContext context, Map<String, dynamic> questionData, QuestionViewModel viewModel) {
    return Column(
      children: [
        Text('Başlangıç Kodu:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(questionData['initialCode'], style: TextStyle(fontFamily: 'Courier')),
        ),
        TextField(
          maxLines: 10,
          decoration: InputDecoration(
            hintText: 'Kodunuzu buraya yazın',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => viewModel.updateCodingAnswer(value),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => _checkAndProceed(viewModel, context),
          child: Text('Çalıştır ve Kontrol Et'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  void _checkAndProceed(QuestionViewModel viewModel, BuildContext context) {
    bool isCorrect = viewModel.checkAnswer();
    if (isCorrect) {
      if (viewModel.isLastQuestion) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tebrikler! Tüm soruları tamamladınız.')),
        );
      } else {
        viewModel.moveToNextQuestion();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Yanlış cevap. Lütfen tekrar deneyin.')),
      );
    }
  }

  @override
  QuestionViewModel viewModelBuilder(BuildContext context) => QuestionViewModel(questions);
}
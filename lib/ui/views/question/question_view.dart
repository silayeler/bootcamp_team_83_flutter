import 'package:bootcamp_team_83_flutter/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'question_viewmodel.dart';

class QuestionView extends StackedView<QuestionViewModel> {
  final List<Map<String, dynamic>> questions;

  const QuestionView({Key? key, required this.questions}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, QuestionViewModel viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
          itemCount: viewModel.questionCount,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var questionData = viewModel.getCurrentQuestion();
            return Stack(
              children: [
                Container(
                  width: screenWidth(context),
                  height: screenHeight(context),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/pathway_backgrounds/pathway1.1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Card(
                    color: Colors.white30.withOpacity(0.75),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: SizedBox(
                      width: screenWidth(context) / 1.1,
                      height: screenHeight(context) / 1.15,
                      child: Column(
                        children: [
                          const SizedBox(height: 15),

                          // İlerleme Çubuğu
                          SizedBox(
                            width: screenWidth(context) / 1.25,
                            height: 15,
                            child: LinearProgressIndicator(
                              value: (viewModel.currentQuestionIndex) /
                                  viewModel.questionCount,
                              backgroundColor: const Color(0xFF404142),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.lightGreenAccent[700]!),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Soru ${questionData['questionIndex'] + 1}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (questionData['questionType'] ==
                                  'multiple_choice' ||
                              questionData['questionType'] == 'fill_in_blank')
                            Column(
                              children: [
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: const BorderSide(width: 5),
                                  ),
                                  child: SizedBox(
                                    width: screenWidth(context) / 1.2,
                                    height: screenHeight(context) / 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        questionData['question'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 20),
                          _buildQuestionContent(
                              context, questionData, viewModel),
                          // Sıfırlama Butonu
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              await viewModel.resetProgress();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('İlerleme sıfırlandı.')),
                              );
                            },
                            child: null,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuestionContent(BuildContext context,
      Map<String, dynamic> questionData, QuestionViewModel viewModel) {
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

  Widget _buildMultipleChoiceQuestion(BuildContext context,
      Map<String, dynamic> questionData, QuestionViewModel viewModel) {
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
                fixedSize: Size(
                    screenWidth(context) / 1.2, screenHeight(context) / 16),
                elevation: 4,
                side: const BorderSide(width: 2.5),
                backgroundColor:
                    viewModel.selectedOption == questionData[option]
                        ? Colors.red
                        : Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
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

  Widget _buildFillInBlankQuestion(BuildContext context,
      Map<String, dynamic> questionData, QuestionViewModel viewModel) {
    List<String> parts = questionData['question'].split('___');
    return Column(
      children: [
        for (int i = 0; i < parts.length; i++) ...[
          Text(parts[i], style: const TextStyle(fontSize: 18)),
          if (i < parts.length - 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Boşluğu doldurun',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => viewModel.updateBlankAnswer(i, value),
              ),
            ),
        ],
        ElevatedButton(
          onPressed: () => _checkAndProceed(viewModel, context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
          ),
          child: const Text('Kontrol Et'),
        ),
      ],
    );
  }

  Widget _buildCodingQuestion(BuildContext context,
      Map<String, dynamic> questionData, QuestionViewModel viewModel) {
    return Column(
      children: [
        const Text('Başlangıç Kodu:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(questionData['initialCode'],
              style: const TextStyle(fontFamily: 'Courier')),
        ),
        TextField(
          maxLines: 10,
          decoration: const InputDecoration(
            hintText: 'Kodunuzu buraya yazın',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => viewModel.updateCodingAnswer(value),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => _checkAndProceed(viewModel, context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
          ),
          child: const Text('Çalıştır ve Kontrol Et'),
        ),
      ],
    );
  }

  void _checkAndProceed(QuestionViewModel viewModel, BuildContext context) {
    bool isCorrect = viewModel.checkAnswer();
    if (isCorrect) {
      if (viewModel.isLastQuestion) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Tebrikler! Tüm soruları tamamladınız.')),
        );
        Navigator.pop(context);
      } else {
        viewModel.moveToNextQuestion();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Yanlış cevap. Lütfen tekrar deneyin.')),
      );
    }
  }

  @override
  QuestionViewModel viewModelBuilder(BuildContext context) =>
      QuestionViewModel(questions);
}

import 'package:flutter/material.dart';

class QuestionView extends StatelessWidget {
  final List<Map<String, dynamic>> questions;

  const QuestionView({Key? key, required this.questions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Questions')),
      body: PageView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          var questionData = questions[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  questionData['question'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                ...['optionA', 'optionB', 'optionC', 'optionD'].map((option) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle option selection
                      },
                      child: Text(questionData[option]),
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}

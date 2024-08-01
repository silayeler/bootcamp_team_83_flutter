import 'package:bootcamp_team_83_flutter/app/app.locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class QuestionViewModel extends BaseViewModel {

  BottomSheetService _bottomSheetService = locator<BottomSheetService>();


  String _codingAnswer = '';
  String _selectedOption = '';
  String get selectedOption => _selectedOption;

  List<String?> _blankAnswers = [];
  List<String?> get blankAnswers => _blankAnswers;

  int _currentQuestionIndex = 0;
  int get currentQuestionIndex => _currentQuestionIndex;

  int get questionCount => _questions.length;

  final List<Map<String, dynamic>> _questions;

  QuestionViewModel(this._questions) {
    _initializeBlankAnswers();
  }

  void _initializeBlankAnswers() {
    var currentQuestion = _questions[_currentQuestionIndex];
    if (currentQuestion['questionType'] == 'fill_in_blank') {
      int blankCount = currentQuestion['question'].split('___').length - 1;
      _blankAnswers = List.filled(blankCount, null);
    }
  }

  void selectOption(String option) {
    _selectedOption = option;
    notifyListeners();
  }

  void updateBlankAnswer(int index, String value) {
    if (index < _blankAnswers.length) {
      _blankAnswers[index] = value;
      notifyListeners();
    }
  }

  void updateCodingAnswer(String value) {
    _codingAnswer = value;
    notifyListeners();
  }

  bool checkAnswer() {
    var currentQuestion = _questions[_currentQuestionIndex];
    bool isCorrect = false;

    switch (currentQuestion['questionType']) {
      case 'multiple_choice':
        isCorrect = _selectedOption == currentQuestion['answer'];
        break;
      case 'fill_in_blank':
        List<String> correctAnswers = List<String>.from(currentQuestion['correctAnswer']);
        isCorrect = _blankAnswers.length == correctAnswers.length &&
            _blankAnswers.every((answer) => answer != null && correctAnswers.contains(answer.trim()));
        break;
      case 'coding':
        isCorrect = _codingAnswer.trim() == currentQuestion['expectedOutput'].trim();
        break;
    }

    return isCorrect;
  }

  void moveToNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      clearAnswers();
      _initializeBlankAnswers();
      notifyListeners();
    }
  }

  void clearAnswers() {
    _selectedOption = '';
    _blankAnswers.clear();
    _codingAnswer = '';
  }

  bool get isLastQuestion => _currentQuestionIndex == _questions.length - 1;

  List<String> getOptions() {
    var currentQuestion = _questions[_currentQuestionIndex];
    return currentQuestion['questionType'] == 'fill_in_blank'
        ? List<String>.from(currentQuestion['options'])
        : [];
  }

  Map<String, dynamic> getCurrentQuestion() {
    return _questions[_currentQuestionIndex];
  }

  void congratulate(){
    _bottomSheetService.showCustomSheet(

      title: "Deneme"
    );

  }


}

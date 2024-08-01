import 'package:stacked/stacked.dart';

class QuestionViewModel extends BaseViewModel {
  String _selectedOption = '';
  String get selectedOption => _selectedOption;

  List<String?> _blankAnswers = [];
  List<String?> get blankAnswers => _blankAnswers;
  String _codingAnswer = '';

  int _currentQuestionIndex = 0;
  int get currentQuestionIndex => _currentQuestionIndex;

  final List<Map<String, dynamic>> questions;

  QuestionViewModel(this.questions) {
    _initializeBlankAnswers();
  }

  void _initializeBlankAnswers() {
    var currentQuestion = questions[_currentQuestionIndex];
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
    var currentQuestion = questions[_currentQuestionIndex];
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
    if (_currentQuestionIndex < questions.length - 1) {
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

  bool get isLastQuestion => _currentQuestionIndex == questions.length - 1;

  List<String> getOptions() {
    var currentQuestion = questions[_currentQuestionIndex];
    return currentQuestion['questionType'] == 'fill_in_blank'
        ? List<String>.from(currentQuestion['options'])
        : [];
  }
}
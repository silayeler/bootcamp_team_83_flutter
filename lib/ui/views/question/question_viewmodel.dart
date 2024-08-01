import 'package:bootcamp_team_83_flutter/app/app.locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class QuestionViewModel extends BaseViewModel {
  BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadProgress();
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
        List<String> correctAnswers =
            List<String>.from(currentQuestion['correctAnswer']);
        isCorrect = _blankAnswers.length == correctAnswers.length &&
            _blankAnswers.every((answer) =>
                answer != null && correctAnswers.contains(answer.trim()));
        break;
      case 'coding':
        isCorrect =
            _codingAnswer.trim() == currentQuestion['expectedOutput'].trim();
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
      _saveProgress(); // Firebase'e ilerlemeyi kaydet
    }
  }

  void moveToPreviousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
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
  bool get isFirstQuestion => _currentQuestionIndex == 0;

  List<String> getOptions() {
    var currentQuestion = _questions[_currentQuestionIndex];
    return currentQuestion['questionType'] == 'fill_in_blank'
        ? List<String>.from(currentQuestion['options'])
        : [];
  }

  Map<String, dynamic> getCurrentQuestion() {
    return _questions[_currentQuestionIndex];
  }

  void congratulate() {
    _bottomSheetService.showCustomSheet(title: "Tebrikler!");
  }

  Future<void> _saveProgress() async {
    // Firebase Firestore'da ilerlemeyi saklama
    final userId =
        'user_id'; // Burada oturum açmış kullanıcı kimliğinizi kullanmalısınız
    await _firestore.collection('users').doc(userId).set({
      'currentQuestionIndex': _currentQuestionIndex,
      'selectedOption': _selectedOption,
      'blankAnswers': _blankAnswers,
      'codingAnswer': _codingAnswer,
    }, SetOptions(merge: true));
  }

  Future<void> _loadProgress() async {
    // Firebase Firestore'dan ilerlemeyi yükleme
    final userId =
        'user_id'; // Burada oturum açmış kullanıcı kimliğinizi kullanmalısınız
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      final data = doc.data();
      _currentQuestionIndex = data?['currentQuestionIndex'] ?? 0;
      _selectedOption = data?['selectedOption'] ?? '';
      _blankAnswers = List<String?>.from(data?['blankAnswers'] ?? []);
      _codingAnswer = data?['codingAnswer'] ?? '';
      notifyListeners();
    }
  }

  Future<void> resetProgress() async {
    final userId =
        'user_id'; // Burada oturum açmış kullanıcı kimliğinizi kullanmalısınız
    await _firestore.collection('users').doc(userId).set({
      'currentQuestionIndex': 0,
      'selectedOption': '',
      'blankAnswers': [],
      'codingAnswer': '',
    }, SetOptions(merge: true));

    _currentQuestionIndex = 0;
    _selectedOption = '';
    _blankAnswers = [];
    _codingAnswer = '';
    notifyListeners();
  }
}

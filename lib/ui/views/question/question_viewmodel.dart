import 'package:bootcamp_team_83_flutter/app/app.bottomsheets.dart';
import 'package:bootcamp_team_83_flutter/app/app.locator.dart';
import 'package:bootcamp_team_83_flutter/services/ai_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/languages/dart.dart';

class QuestionViewModel extends BaseViewModel {
  final _aiService = locator<AIService>();
  final _bottomSheetService = locator<BottomSheetService>();

  final userId = FirebaseAuth.instance.currentUser!.uid;
  final String? _apiKey = dotenv.env['Google_Gemini_Api_Key'];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late CodeController codeController;

  String? get apiKey => _apiKey;

  bool get isLastQuestion => _currentQuestionIndex == _questions.length - 1;
  bool get isFirstQuestion => _currentQuestionIndex == 0;

  String get selectedOption => _selectedOption;
  String get blankAnswer => _blankAnswer;

  int get currentQuestionIndex => _currentQuestionIndex;
  int get questionCount => _questions.length;

  bool get isAnswerChecked => _isAnswerChecked;

  final List<Map<String, dynamic>> _questions;
  var _currentQuestionIndex = 0;
  String _selectedOption = '';
  String _blankAnswer = '';
  bool _isAnswerChecked = false;

  QuestionViewModel(this._questions) {
    codeController = CodeController(
      text: '',
      language: dart,
    );
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadProgress();
    _initializeCodeController();
  }

  void _initializeCodeController() {
    var currentQuestion = getCurrentQuestion();
    if (currentQuestion['questionType'] == 'coding') {
      codeController.text = currentQuestion['initialCode'] ?? '';
    } else {
      codeController.text = '';
    }
    notifyListeners();
  }

  void moveToNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      clearAnswers();
      _initializeCodeController();
      notifyListeners();
      _saveProgress();
    }
  }


  void selectOption(String option) {
    _selectedOption = option;
    notifyListeners();
  }

  void updateBlankAnswer(String value) {
    _blankAnswer = value;
    notifyListeners();
  }

  void updateCodingAnswer(String value) {
    codeController.text = value;
    notifyListeners();
  }

  bool checkAnswer() {
    var currentQuestion = getCurrentQuestion();
    bool isCorrect = false;

    switch (currentQuestion['questionType']) {
      case 'multiple_choice':
        isCorrect = _selectedOption == currentQuestion['answer'];
        break;
      case 'fill_in_blank':
        isCorrect = _blankAnswer == currentQuestion['answer'];
        break;
      case 'coding':
        isCorrect = _checkCodingAnswer(codeController.text, currentQuestion['expectedOutput']);
        break;
    }

    _isAnswerChecked = true;
    rebuildUi();
    return isCorrect;
  }

  bool _checkCodingAnswer(String code, String expectedOutput) {
    return code.contains(expectedOutput);
  }

  void clearAnswers() {
    _selectedOption = '';
    _blankAnswer = '';
    rebuildUi();
  }

  void resetQuestion() {
    _isAnswerChecked = false;
    clearAnswers();
    notifyListeners();
  }

  String getCorrectAnswer() {
    var currentQuestion = getCurrentQuestion();
    switch (currentQuestion['questionType']) {
      case 'multiple_choice':
        return currentQuestion['answer'];
      case 'fill_in_blank':
        return currentQuestion['answer'];
      case 'coding':
        return currentQuestion['expectedOutput'];
      default:
        return 'Bilinmeyen soru tipi: ${currentQuestion['questionType']}';
    }
  }

  List<String> getOptions() {
    var currentQuestion = getCurrentQuestion();
    return currentQuestion['questionType'] == 'fill_in_blank'
        ? List<String>.from(currentQuestion['options'])
        : [];
  }

  Map<String, dynamic> getCurrentQuestion() {
    return _questions[_currentQuestionIndex];
  }

  void showCorrectAnswerSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: "Tebrikler!",
      description: "Doğru Cevap",
      mainButtonTitle: "Devam Et",
      barrierDismissible: false,
      data: {
        "isCorrect": true,
        "questions": _questions,
        "currentQuestionIndex": _currentQuestionIndex
      },
    ).then((value) {
      if (value != null && value.confirmed) {
        moveToNextQuestion();
        resetQuestion();
      }
    });
  }

  void showIncorrectAnswerSheet(String correctAnswer) {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: "Üzgünüm!",
      description: "Yanlış Cevap. Doğru cevap: $correctAnswer",
      mainButtonTitle: "Tekrar Dene",
      barrierDismissible: false,
      data: {
        "isCorrect": false,
        "questions": _questions,
        "currentQuestionIndex": _currentQuestionIndex
      },
    ).then((value) {
      if (value != null && value.confirmed) {
        resetQuestion();
      }
    });
  }


  Future<void> askAI(Map<String, dynamic> questionData) async {
    await _aiService.askAI(questionData);
  }

  void congratulate() {
    _bottomSheetService.showCustomSheet(title: "Tebrikler!");
  }

  Future<void> _saveProgress() async {
    await _firestore.collection('users').doc(userId).set({
      'currentQuestionIndex': _currentQuestionIndex,
      'selectedOption': _selectedOption,
      'blankAnswer': _blankAnswer,
      'codingAnswer': codeController.text,
    }, SetOptions(merge: true));
  }

  Future<void> _loadProgress() async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      final data = doc.data();
      _selectedOption = data?['selectedOption'] ?? '';
      _blankAnswer = data?['blankAnswer'] ?? '';
      codeController.text = data?['codingAnswer'] ?? '';
      notifyListeners();
    }
  }

  Future<void> resetProgress() async {
    await _firestore.collection('users').doc(userId).set({
      'currentQuestionIndex': 0,
      'selectedOption': '',
      'blankAnswer': '',
      'codingAnswer': '',
    }, SetOptions(merge: true));

    _currentQuestionIndex = 0;
    _selectedOption = '';
    _blankAnswer = '';
    codeController.text = '';
    notifyListeners();
  }
}

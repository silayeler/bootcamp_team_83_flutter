import 'package:bootcamp_team_83_flutter/services/chapter_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class QuestionFormViewModel extends BaseViewModel {
  final ChapterService _chapterService = ChapterService();

  String? selectedSectionId;
  String? selectedPathwayId;
  String? selectedItemId;
  String? selectedQuestionType;
  List<DropdownMenuItem<String>> sectionItems = [];
  List<DropdownMenuItem<String>> pathwayItems = [];
  List<DropdownMenuItem<String>> itemItems = [];

  TextEditingController questionController = TextEditingController();
  TextEditingController optionAController = TextEditingController();
  TextEditingController optionBController = TextEditingController();
  TextEditingController optionCController = TextEditingController();
  TextEditingController optionDController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  TextEditingController initialCodeController = TextEditingController();
  TextEditingController expectedOutputController = TextEditingController();
  TextEditingController fillInBlankOptionsController = TextEditingController();
  TextEditingController fillInBlankAnswersController = TextEditingController();



  QuestionFormViewModel() {
    _loadSections();
  }

  Future<void> _loadSections() async {
    setBusy(true);
    var snapshot = await _chapterService.getSections();
    sectionItems = snapshot.docs.map((doc) {
      return DropdownMenuItem(
        value: doc.id,
        child: Text(doc['title']),
      );
    }).toList();
    setBusy(false);
  }

  Future<void> _loadPathways(String sectionId) async {
    setBusy(true);
    var snapshot = await _chapterService.getPathways(sectionId);
    pathwayItems = snapshot.docs.map((doc) {
      return DropdownMenuItem(
        value: doc.id,
        child: Text(doc['title']),
      );
    }).toList();
    setBusy(false);
  }

  Future<void> _loadItems(String sectionId, String pathwayId) async {
    setBusy(true);
    var snapshot = await _chapterService.getPathwayItems(sectionId, pathwayId);
    itemItems = snapshot.docs.map((doc) {
      return DropdownMenuItem(
        value: doc.id,
        child: Text(doc['title']),
      );
    }).toList();
    setBusy(false);
  }

  void setSelectedSectionId(String value) {
    selectedSectionId = value;
    selectedPathwayId = null;
    selectedItemId = null;
    pathwayItems = [];
    itemItems = [];
    notifyListeners();
    _loadPathways(value);
  }

  void setSelectedPathwayId(String value) {
    selectedPathwayId = value;
    selectedItemId = null;
    itemItems = [];
    notifyListeners();
    _loadItems(selectedSectionId!, value);
  }

  void setSelectedItemId(String value) {
    selectedItemId = value;
    notifyListeners();
  }

  void setSelectedQuestionType(String value) {
    selectedQuestionType = value;
    notifyListeners();
  }

  Future<void> createQuestion() async {
    if (selectedSectionId != null &&
        selectedPathwayId != null &&
        selectedItemId != null &&
        selectedQuestionType != null) {
      Map<String, dynamic> questionData = {
        'question': questionController.text,
        'questionType': selectedQuestionType,
      };

      switch (selectedQuestionType) {
        case 'multiple_choice':
          questionData.addAll({
            'optionA': optionAController.text,
            'optionB': optionBController.text,
            'optionC': optionCController.text,
            'optionD': optionDController.text,
            'answer': answerController.text,
          });
          break;
        case 'fill_in_blank':
          questionData['options'] = fillInBlankOptionsController.text.split('\n');
          questionData['correctAnswer'] = fillInBlankAnswersController.text.split('\n');
          break;
        case 'coding':
          questionData.addAll({
            'initialCode': initialCodeController.text,
            'expectedOutput': expectedOutputController.text,
          });
          break;
      }

      await _chapterService.createQuestion(
        selectedSectionId!,
        selectedPathwayId!,
        selectedItemId!,
        questionData,
      );
    }
  }
}
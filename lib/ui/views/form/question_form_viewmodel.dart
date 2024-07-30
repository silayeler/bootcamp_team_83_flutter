import 'package:bootcamp_team_83_flutter/services/chapter_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class QuestionFormViewModel extends BaseViewModel {
  final ChapterService _chapterService = ChapterService();

  String? selectedSectionId;
  String? selectedPathwayId;
  String? selectedItemId;
  List<DropdownMenuItem<String>> sectionItems = [];
  List<DropdownMenuItem<String>> pathwayItems = [];
  List<DropdownMenuItem<String>> itemItems = [];

  TextEditingController questionController = TextEditingController();
  TextEditingController optionAController = TextEditingController();
  TextEditingController optionBController = TextEditingController();
  TextEditingController optionCController = TextEditingController();
  TextEditingController optionDController = TextEditingController();
  TextEditingController answerController = TextEditingController();

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
    selectedPathwayId = null; // Reset selected pathway
    selectedItemId = null; // Reset selected item
    pathwayItems = []; // Clear pathway items
    itemItems = []; // Clear item items
    notifyListeners();
    _loadPathways(value);
  }

  void setSelectedPathwayId(String value) {
    selectedPathwayId = value;
    selectedItemId = null; // Reset selected item
    itemItems = []; // Clear item items
    notifyListeners();
    _loadItems(selectedSectionId!, value);
  }

  void setSelectedItemId(String value) {
    selectedItemId = value;
    notifyListeners();
  }

  Future<void> createQuestion() async {
    if (selectedSectionId != null &&
        selectedPathwayId != null &&
        selectedItemId != null) {
      await _chapterService.createQuestion(
        selectedSectionId!,
        selectedPathwayId!,
        selectedItemId!,
        {
          'question': questionController.text,
          'optionA': optionAController.text,
          'optionB': optionBController.text,
          'optionC': optionCController.text,
          'optionD': optionDController.text,
          'answer': answerController.text, // Doğru cevap ekleniyor
        },
      );
    }
  }
}

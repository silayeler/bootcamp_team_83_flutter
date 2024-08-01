import 'package:bootcamp_team_83_flutter/services/chapter_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PathwayFormViewModel extends BaseViewModel {
  final ChapterService _chapterService = ChapterService();
  String? selectedSectionId;
  List<DropdownMenuItem<String>> sectionItems = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController itemNumberController = TextEditingController();
  TextEditingController backgroundUrlController = TextEditingController();
  TextEditingController itemImageUrlController = TextEditingController();

  PathwayFormViewModel() {
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

  void setSelectedSectionId(String value) {
    selectedSectionId = value;
    notifyListeners();
  }

  Future<void> createPathway() async {
    if (selectedSectionId != null) {
      var pathwayRef = await _chapterService.createPathway(selectedSectionId!, {
        'title': titleController.text,
        'numberOfStars': int.parse(itemNumberController.text),
        'backgroundUrl': backgroundUrlController.text,
        'itemImageUrl': itemImageUrlController.text,
      });

      int numberOfItems = int.parse(itemNumberController.text);
      for (int i = 0; i < numberOfItems; i++) {
        await _chapterService
            .createPathwayItem(selectedSectionId!, pathwayRef.id, {
          'title': 'Star ${i + 1}',
        });
      }
    }
  }
}

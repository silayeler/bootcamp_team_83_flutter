import 'package:bootcamp_team_83_flutter/models/user_progress_model.dart';
import 'package:bootcamp_team_83_flutter/services/chapter_service.dart';
import 'package:bootcamp_team_83_flutter/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';

class ChapterViewModel extends BaseViewModel{

  final ChapterService _chapterService = ChapterService();
  final UserService _userService = UserService();

  Future<bool> isSectionCompleted(String userId, String sectionId) async {
    UserProgress? userProgress =
    await _userService.getUserProgress(userId);
    if (userProgress != null) {
      return userProgress.completedSections[sectionId] ?? false;
    }
    return false;
  }

  Future<QuerySnapshot> getChapters() async {
    setBusy(true);
    QuerySnapshot chapters = await _chapterService.getSections();
    setBusy(false);
    return chapters;
  }


}
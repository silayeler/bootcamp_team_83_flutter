import 'package:bootcamp_team_83_flutter/models/user_progress_model.dart';
import 'package:bootcamp_team_83_flutter/services/chapter_service.dart';
import 'package:bootcamp_team_83_flutter/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';

class PathwayViewModel extends BaseViewModel {
   late String sectionId;
   late String pathwayId;

   final ChapterService _chapterService = ChapterService();
   final UserService _userService = UserService();

   Future isSectionCompleted(String userId, String sectionId) async {
     UserProgress? userProgress =
     await _userService.getUserProgress(userId);
     if (userProgress != null) {
       return userProgress.completedLevels[sectionId] ?? false;
     }
     return false;
   }

   Future<QuerySnapshot> getPathways() async {
     setBusy(true);
     QuerySnapshot chapters = await _chapterService.getPathways(sectionId);
     setBusy(false);
     return chapters;
   }

   Future<QuerySnapshot> getPathwayItems() async {
     setBusy(true);
     QuerySnapshot chapters = await _chapterService.getPathwayItems(sectionId,pathwayId);
     setBusy(false);
     return chapters;
   }
}

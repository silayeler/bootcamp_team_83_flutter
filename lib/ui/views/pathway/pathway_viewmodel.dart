import 'package:bootcamp_team_83_flutter/app/app.locator.dart';
import 'package:bootcamp_team_83_flutter/models/user_progress_model.dart';
import 'package:bootcamp_team_83_flutter/services/chapter_service.dart';
import 'package:bootcamp_team_83_flutter/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';

class PathwayViewModel extends BaseViewModel {
  late String sectionId;
  late String pathwayId;

  final _chapterService = locator<ChapterService>();
  final _userService = locator<UserService>();

  Future isSectionCompleted(String userId, String sectionId) async {
    UserProgress? userProgress = await _userService.getUserProgress(userId);
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
    QuerySnapshot chapters =
        await _chapterService.getPathwayItems(sectionId, pathwayId);
    setBusy(false);
    return chapters;
  }

  // İlerlemeyi Firebase'e kaydet
  Future<void> saveProgress(String userId, int currentQuestionIndex) async {
    final progressData = {
      'currentQuestionIndex': currentQuestionIndex,
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('sections')
        .doc(sectionId)
        .set(progressData, SetOptions(merge: true));
  }

  // Firebase'den ilerlemeyi yükle
  Future<int> loadProgress(String userId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('sections')
        .doc(sectionId)
        .get();

    if (snapshot.exists) {
      return snapshot.data()?['currentQuestionIndex'] ?? 0;
    } else {
      return 0; // Eğer kayıt yoksa, başlangıç sorusuna dön
    }
  }

  // Kullanıcının ilerlemesini güncelle
  Future<void> updateProgress(String userId, int currentQuestionIndex) async {
    await saveProgress(userId, currentQuestionIndex);
  }
}

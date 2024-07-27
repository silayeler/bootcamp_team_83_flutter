import 'package:bootcamp_team_83_flutter/models/user_progress_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChapterService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Bölüm oluşturma
  Future<void> createSection(Map<String, dynamic> sectionData) async {
    try {
      await _firestore.collection('sections').add(sectionData);
    } catch (e) {
      print('Error creating section: $e');
    }
  }

  // Yıldız sayfası oluşturma
  Future<void> createStarPage(String sectionId,
      Map<String, dynamic> starPageData) async {
    try {
      await _firestore
          .collection('sections')
          .doc(sectionId)
          .collection('starPages')
          .add(starPageData);
    } catch (e) {
      print('Error creating star page: $e');
    }
  }

  // Kullanıcı ilerlemesini alma
  Future<UserProgress?> getUserProgress(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('userProgress').doc(
          userId).get();
      if (doc.exists) {
        return UserProgress.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error getting user progress: $e');
      return null;
    }
  }

  // Kullanıcı ilerlemesini güncelleme
  Future<void> updateUserProgress(String userId,
      UserProgress userProgress) async {
    try {
      await _firestore.collection('userProgress').doc(userId).set(
          userProgress.toMap());
    } catch (e) {
      print('Error updating user progress: $e');
    }
  }

  // Tüm bölümleri alma
  Future<QuerySnapshot> getSections() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('sections').get();
      return querySnapshot;
    } catch (e) {
      print('Error getting sections: $e');
      rethrow;
    }
  }
}
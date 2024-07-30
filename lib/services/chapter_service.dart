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

  // Görev Yolu sayfası oluşturma
  Future<DocumentReference> createPathway(
      String sectionId, Map<String, dynamic> pathwayData) async {
    try {
      var pathwayRef = await _firestore
          .collection('sections')
          .doc(sectionId)
          .collection('pathways')
          .add(pathwayData);
      return pathwayRef;
    } catch (e) {
      print('Error creating pathway: $e');
      rethrow;
    }
  }

  // Pathway item oluşturma
  Future<void> createPathwayItem(
      String sectionId, String pathwayId, Map<String, dynamic> itemData) async {
    try {
      await _firestore
          .collection('sections')
          .doc(sectionId)
          .collection('pathways')
          .doc(pathwayId)
          .collection('items')
          .add(itemData);
    } catch (e) {
      print('Error creating pathway item: $e');
    }
  }

  // Soru oluşturma
  Future<void> createQuestion(String sectionId, String pathwayId, String itemId,
      Map<String, dynamic> questionData) async {
    try {
      await _firestore
          .collection('sections')
          .doc(sectionId)
          .collection('pathways')
          .doc(pathwayId)
          .collection('items')
          .doc(itemId)
          .collection('questions')
          .add(questionData);
    } catch (e) {
      print('Error creating question: $e');
    }
  }

  // Tüm bölümleri alma
  Future<QuerySnapshot> getSections() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('sections').get();
      return querySnapshot;
    } catch (e) {
      print('Error getting sections: $e');
      rethrow;
    }
  }

  // Belirli bir bölümdeki tüm görev yollarını alma
  Future<QuerySnapshot> getPathways(String sectionId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('sections')
          .doc(sectionId)
          .collection('pathways')
          .get();
      return querySnapshot;
    } catch (e) {
      print('Error getting pathways: $e');
      rethrow;
    }
  }

  // Belirli bir görev yolundaki tüm itemleri alma
  Future<QuerySnapshot> getPathwayItems(
      String sectionId, String pathwayId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('sections')
          .doc(sectionId)
          .collection('pathways')
          .doc(pathwayId)
          .collection('items')
          .get();
      return querySnapshot;
    } catch (e) {
      print('Error getting pathway items: $e');
      rethrow;
    }
  }
}

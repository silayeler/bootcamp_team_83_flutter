import 'package:bootcamp_team_83_flutter/models/user_model.dart';
import 'package:bootcamp_team_83_flutter/models/user_progress_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get user => _firebaseAuth.currentUser;

  Future<String> getUserNameSurname() async {
    if (user != null) {
      DocumentSnapshot doc =
      await _firestore.collection('users').doc(user!.uid).get();
      return doc['name'] + " " + doc['surname'];
    }
    return "User not found";
  }

  Future<String> getUserProfileImageUrl() async {
    if (user != null) {
      DocumentSnapshot doc =
      await _firestore.collection('users').doc(user!.uid).get();
      return doc['profileImageUrl'];
    }else {

      return "User not found";

    }

  }

  Future<void> updateUserProfileImageUrl(String imageUrl) async {
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user!.uid)
          .update({'profileImageUrl': imageUrl});
    }
  }

  Future<void> saveUserData(UserModel userModel) async {
    await _firestore
        .collection('users')
        .doc(userModel.id)
        .set(userModel.toMap());
  }

  // Misafir girişi kontrolü
  Future<bool> isGuestLogin() async {
    return user == null || user!.isAnonymous;
  }



  // Kullanıcı ilerlemesini alma
  Future<UserProgress?> getUserProgress(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('userProgress').doc(userId).get();
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
  Future<void> updateUserProgress(String userId, UserProgress userProgress) async {
    try {
      await _firestore.collection('userProgress').doc(userId).set(userProgress.toMap());
    } catch (e) {
      print('Error updating user progress: $e');
    }
  }

}
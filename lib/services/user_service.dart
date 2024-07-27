import 'package:bootcamp_team_83_flutter/models/user_model.dart';
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
    }
    return "User not found";
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
}
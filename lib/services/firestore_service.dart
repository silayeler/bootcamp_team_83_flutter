import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get user => _firebaseAuth.currentUser;

  
}

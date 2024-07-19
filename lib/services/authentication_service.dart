import 'dart:async';
import 'package:bootcamp_team_83_flutter/app/app.locator.dart';
import 'package:bootcamp_team_83_flutter/app/app.router.dart';
import 'package:bootcamp_team_83_flutter/models/user_model.dart';
import 'package:bootcamp_team_83_flutter/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthenticationService {
  // Fields
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  static const int snackbarDuration = 2000;

  // Services
  final _snackbarService = locator<SnackbarService>();
  final _navigationService = locator<NavigationService>();
  final _firestoreService = locator<FirestoreService>();


  Future<bool> userLoggedIn() async {
    return _firebaseAuth.currentUser != null;
  }

  // Signup Function
  Future<User?> signUpWithEmailAndPassword(String email, String password,
      String confirmPassword, String name, String surname) async {
    if (name.isEmpty || surname.isEmpty || email.isEmpty) {
      _snackbarService.showSnackbar(
        message: 'Bir alan boş bırakılamaz',
        duration: const Duration(milliseconds: snackbarDuration),
      );
      return null;
    }

    if (password.isNotEmpty && password != confirmPassword) {
      _snackbarService.showSnackbar(
        title: 'Kayıt Başarısız',
        message: 'Şifreler uyuşmuyor.',
        duration: const Duration(milliseconds: snackbarDuration),
      );
      return null;
    }

    if (password.isNotEmpty && password.length < 6) {
      _snackbarService.showSnackbar(
        title: 'Kayıt Başarısız',
        message: 'Şifre en az 6 karakter olmalı.',
        duration: const Duration(milliseconds: snackbarDuration),
      );
      return null;
    }

    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        _snackbarService.showSnackbar(
          title: 'Kayıt Başarılı',
          message: 'Merhaba $name',
          duration: const Duration(milliseconds: snackbarDuration),
        );

        if (user != null) {
          final userModel = UserModel(
            id: user.uid,
            name: name,
            surname: surname,
            email: email,
            createdAt: DateTime.now(),
          );

          await _firestoreService.saveUserData(userModel);

        }else{
          _snackbarService.showSnackbar(
            title: 'Giriş Başarılı!',
            message: "Ama kullanıcı database'e kaydedilemedi",
            duration: const Duration(milliseconds: snackbarDuration),
          );
        }
      } else {
        _snackbarService.showSnackbar(
          title: 'Kayıt Başarısız',
          message: 'Kullanıcı oluşturulamadı.',
          duration: const Duration(milliseconds: snackbarDuration),
        );
        return null;
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'Bu e-posta adresi zaten kullanılıyor.';
          break;
        case 'invalid-email':
          errorMessage = 'Geçersiz e-posta adresi.';
          break;
        case 'weak-password':
          errorMessage = 'Zayıf şifre, lütfen daha güçlü bir şifre kullanın.';
          break;
        default:
          errorMessage = 'Hata: ${e.message}';
      }
      _snackbarService.showSnackbar(
        title: 'Kayıt Başarısız',
        message: errorMessage,
        duration: const Duration(milliseconds: snackbarDuration),
      );

      return null;
    } catch (e) {
      _snackbarService.showSnackbar(
        title: 'Kayıt Başarısız',
        message: 'Bir hata oluştu: $e',
        duration: const Duration(milliseconds: snackbarDuration),
      );
      return null;
    }
  }

  // Login Function
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _snackbarService.showSnackbar(
        title: 'Giriş Başarılı',
        message: 'Hoşgeldin',
        duration: const Duration(milliseconds: snackbarDuration),
      );
      _navigationService.replaceWithHomeView();
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Geçersiz e-posta adresi.';
          break;
        case 'user-disabled':
          errorMessage = 'Kullanıcı devre dışı bırakılmış.';
          break;
        case 'user-not-found':
          errorMessage = 'Kullanıcı bulunamadı.';
          break;
        case 'wrong-password':
          errorMessage = 'Yanlış şifre.';
          break;
        default:
          errorMessage = 'Giriş başarısız. Hata: ${e.message}';
      }
      _snackbarService.showSnackbar(
        title: 'Giriş Başarısız',
        message: errorMessage,
        duration: const Duration(milliseconds: snackbarDuration),
      );
      return null;
    } catch (e) {
      _snackbarService.showSnackbar(
        title: 'Giriş Başarısız',
        message: 'Bir hata oluştu: $e',
        duration: const Duration(milliseconds: snackbarDuration),
      );
      return null;
    }
  }
}

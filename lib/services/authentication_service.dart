import 'dart:async';

import 'package:bootcamp_team_83_flutter/app/app.locator.dart';
import 'package:bootcamp_team_83_flutter/app/app.router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthenticationService {


  // Fieldlar
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  static const int snackbarDuration = 2000;


  // Servisler
  final _snackbarService = locator<SnackbarService>();
  final _navigationService = locator<NavigationService>();

  Future<bool> userLoggedIn() async {
    return _firebaseAuth.currentUser != null;
  }

  //SİGNUP FONKSİYONU

  Future<User?> signUpWithEmailAndPassword(String email, String password,
      String confirmPassword, String name, String surname) async {
    if (password != confirmPassword) {
      _snackbarService.showSnackbar(
        title: 'Kayıt Başarısız',
        message: 'Şifreler uyuşmuyor.',
      );
      Timer(const Duration(milliseconds: snackbarDuration), () {
        _snackbarService.closeSnackbar();
      });
      return null;
    }

    if (password.length < 6) {
      _snackbarService.showSnackbar(
        title: 'Kayıt Başarısız',
        message: 'Şifre en az 6 karakter olmalı.',
      );
      Timer(const Duration(milliseconds: snackbarDuration), () {
        _snackbarService.closeSnackbar();
      });
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
        );
        Timer(const Duration(milliseconds: snackbarDuration), () {
          _snackbarService.closeSnackbar();
        });

        return user;
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
          errorMessage = 'Kayıt başarısız. Hata: ${e.message}';
      }

      _snackbarService.showSnackbar(
        title: 'Kayıt Başarısız',
        message: errorMessage,
      );
      Timer(const Duration(milliseconds: snackbarDuration), () {
        _snackbarService.closeSnackbar();
      });

      return null;
    } catch (e) {
      _snackbarService.showSnackbar(
        title: 'Kayıt Başarısız',
        message: 'Bir hata oluştu: $e',
      );
      Timer(const Duration(milliseconds: snackbarDuration), () {
        _snackbarService.closeSnackbar();
      });

      return null;
    }
  }

  //LOGİN FONKSİYONU
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
      );
      Timer(const Duration(milliseconds: snackbarDuration), () {
        _snackbarService.closeSnackbar();
      });
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
        case 'invalid-credential':
          errorMessage = 'Email veya şifre yanlış';
          break;
        default:
          errorMessage = 'Giriş başarısız. Hata: ${e.message}';
      }
      _snackbarService.showSnackbar(
        title: 'Giriş Başarısız',
        message: errorMessage,
      );
      Timer(const Duration(milliseconds: snackbarDuration), () {
        _snackbarService.closeSnackbar();
      });
      return null;
    } catch (e) {
      _snackbarService.showSnackbar(
        title: 'Giriş Başarısız',
        message: 'Bir hata oluştu: $e',
      );
      Timer(const Duration(milliseconds: snackbarDuration), () {
        _snackbarService.closeSnackbar();
      });
      return null;
    }
  }

}

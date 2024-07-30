import 'package:bootcamp_team_83_flutter/app/app.locator.dart';
import 'package:bootcamp_team_83_flutter/app/app.router.dart';
import 'package:bootcamp_team_83_flutter/services/authentication_service.dart';
import 'package:bootcamp_team_83_flutter/services/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _storageService = locator<StorageService>();
  final _snackbarService=locator<SnackbarService>();

  static const int snackbarDuration = 2000; // 2 saniye örnek olarak

  Future<void> signIn(String email, String password) async {
    setBusy(true);
    try {
      User? user = await _authenticationService.signInWithEmailAndPassword(
          email, password);
      bool hasSeenStory = await _storageService.hasSeenStory();
      if (hasSeenStory && user != null) {
        _snackbarService.showSnackbar(
          title: 'Giriş Başarılı',
          message: 'Hoşgeldin',
          duration: const Duration(milliseconds: snackbarDuration),
        );
        _navigationService.replaceWithHomeView();
      } else {
        _navigationService.replaceWithStoryView();
      }
    } catch (e) {
      print('Beklenmedik bir hata oluştu: $e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> guestSignIn() async {
    setBusy(true);
    try {
      // Misafir olarak giriş yapacak kullanıcıyı oluştur
      UserCredential userCredential =
          (await _authenticationService.signInAnonymously()) as UserCredential;
      User? user = userCredential.user;

      // Misafir kullanıcının belirli bir ekrana yönlendirilmesi
      bool hasSeenStory = await _storageService.hasSeenStory();
      if (hasSeenStory && user != null) {
        _navigationService.replaceWithHomeView();
      } else  {
        _navigationService.replaceWithStoryView();
      }
    } catch (e) {
      print('Misafir girişi sırasında bir hata oluştu: $e');
    } finally {
      setBusy(false);
    }
  }

  void goToRegister() {
    _navigationService.replaceWithSignupView();
  }
}

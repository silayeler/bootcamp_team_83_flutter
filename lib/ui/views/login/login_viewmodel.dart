import 'package:bootcamp_team_83_flutter/app/app.locator.dart';
import 'package:bootcamp_team_83_flutter/app/app.router.dart';
import 'package:bootcamp_team_83_flutter/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  static const int snackbarDuration = 2000; // 2 saniye örnek olarak

  Future<void> signIn(String email, String password) async {
    setBusy(true);
    try {
      User? user = await _authenticationService.signInWithEmailAndPassword(
          email, password);
      if (user != null) {
        _navigationService.replaceWithHomeView();
      }
    } catch (e) {
      print('Beklenmedik bir hata oluştu: $e');
    } finally {
      setBusy(false);
    }
  }

  void goToRegister() {
    _navigationService.replaceWithSignupView();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

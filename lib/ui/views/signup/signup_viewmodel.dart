import 'package:bootcamp_team_83_flutter/app/app.locator.dart';
import 'package:bootcamp_team_83_flutter/app/app.router.dart';
import 'package:bootcamp_team_83_flutter/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  Future<void> signUp(
    String email,
    String password,
    String confirmpassword,
    String name,
    String surname,
  ) async {
    setBusy(true);
    try {
      User? user = await _authenticationService.signUpWithEmailAndPassword(
        email,
        password,
        confirmpassword,
        name,
        surname,
      );
      if (user != null) {
        _navigationService.replaceWithLoginView();
      }
    } catch (e) {
      print('Beklenmedik bir hata oluştu: $e');
    } finally {
      setBusy(false);
    }
  }

  void goToLogin() {
    _navigationService.replaceWithLoginView();
  }
}

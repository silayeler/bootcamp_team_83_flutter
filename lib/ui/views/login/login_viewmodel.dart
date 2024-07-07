import 'package:bootcamp_team_83_flutter/app/app.locator.dart';
import 'package:bootcamp_team_83_flutter/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {

  final _navigationService = locator<NavigationService>();

  signIn(String text, String text2) {

  }

  void goToRegister() {
    _navigationService.replaceWithSignupView();
  }
}

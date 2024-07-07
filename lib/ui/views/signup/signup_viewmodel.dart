import 'package:bootcamp_team_83_flutter/app/app.locator.dart';
import 'package:bootcamp_team_83_flutter/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignupViewModel extends BaseViewModel {

  final _navigationService =locator<NavigationService>();

  void signUp(
      String email,
      String password,
      String confirmpassword,
      String name,
      String surname,) {

  }

  void goToLogin() {
    _navigationService.replaceWithLoginView();
  }
}

import 'package:bootcamp_team_83_flutter/app/app.locator.dart';
import 'package:bootcamp_team_83_flutter/app/app.router.dart';
import 'package:bootcamp_team_83_flutter/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();

  String? userId;

  String _userName = "";

  bool isGuestLogin = false;

  String get userName => isGuestLogin ? 'Misafir' : _userName;

  // Initialize the ViewModel
  Future<void> initialize() async {
    userId = FirebaseAuth.instance.currentUser?.uid;

    if (isGuestLogin || userId == null) {
      loginAsGuest();
    } else {
      await fetchUserName();
    }
  }

  Future<void> fetchUserName() async {
    if (isGuestLogin || userId == null) return;
    setBusy(true);
    _userName = await _userService.getUserNameSurname() ?? "";
    setBusy(false);
    notifyListeners();
  }

  void loginAsGuest() {
    isGuestLogin = true;
    _userName = 'Misafir';
    notifyListeners();
  }

  Future<void> signOut() async {
    setBusy(true);
    await FirebaseAuth.instance.signOut();
    _navigationService.replaceWith(Routes.loginView);
    setBusy(false);
  }

  void goToPathWay() {
    // Implement navigation logic
  }
}
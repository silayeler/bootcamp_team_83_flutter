import 'package:bootcamp_team_83_flutter/app/app.locator.dart';
import 'package:bootcamp_team_83_flutter/app/app.router.dart';
import 'package:bootcamp_team_83_flutter/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _firestoreService = locator<FirestoreService>();

  String _userName = "";
  bool isGuest = false;

  String get userName => isGuest ? 'Misafir' : _userName;

  Future<void> fetchUserName() async {
    if (isGuest) return; // Eğer misafir girişiyse veritabanına sorgu yapma
    setBusy(true);
    _userName = await _firestoreService.getUserNameSurname();
    setBusy(false);
    rebuildUi();
  }

  void loginAsGuest() {
    isGuest = true;
    _userName = 'Misafir'; // Misafir adı hemen belirlenir
    rebuildUi();
  }

  Future<void> signOut() async {
    setBusy(true);
    await FirebaseAuth.instance.signOut();
    _navigationService.replaceWith(Routes.loginView);
    setBusy(false);
  }
}

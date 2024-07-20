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
  String get userName => _userName;

  get counterLabel => null;

  Future<void> fetchUserName() async {
    setBusy(true);
    _userName = await _firestoreService.getUserNameSurname();
    setBusy(false);
    rebuildUi();
  }


  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _navigationService.replaceWithLoginView();
  }

  void incrementCounter() {}

  void showBottomSheet() {}


}




// void incrementCounter() {
//   _counter++;
//   rebuildUi();
// }
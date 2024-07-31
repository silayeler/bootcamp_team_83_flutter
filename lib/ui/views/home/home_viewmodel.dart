import 'package:bootcamp_team_83_flutter/app/app.locator.dart';
import 'package:bootcamp_team_83_flutter/services/authentication_service.dart';
import 'package:bootcamp_team_83_flutter/services/user_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _userService = locator<UserService>();

  String _userName = '';
  String get userName => _userName;

  String? get userId => _authenticationService.currentUser?.uid;
  bool get isGuest => _authenticationService.currentUser?.isAnonymous ?? false;

  Future<void> initialize() async {
    await fetchUserName();
  }

  Future<void> fetchUserName() async {
    if (userId == null) return;
    setBusy(true);
    try {
      _userName = await _userService.getUserNameSurname() ?? 'Misafir';
    } catch (e) {
      print('Hata: $e');
      _userName = 'Misafir'; // Hata durumunda boş bir isim
    } finally {
      setBusy(false);
      notifyListeners(); // UI'yi yeniden oluşturun
    }
  }

  void signOut() async {
    await _authenticationService.signOut();
    // Giriş yapıldıktan sonra UI'yi güncellemek için gerekli işlemleri yapın
    notifyListeners();
  }
}

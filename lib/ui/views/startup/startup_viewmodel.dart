import 'package:stacked/stacked.dart';
import 'package:bootcamp_team_83_flutter/app/app.locator.dart';
import 'package:bootcamp_team_83_flutter/app/app.router.dart';
import 'package:bootcamp_team_83_flutter/services/authentication_service.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  // Uygulamaya girmeden önce gerçekleşmesi gereken her şey buraya yazılır.
  Future<void> runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3)); // Yüklenme süresi

    // Kullanıcının oturum açıp açmadığını kontrol et
    bool isLoggedIn = await _authenticationService.userLoggedIn();

    if (isLoggedIn) {
      // HomeView'e yönlendir
      _navigationService.replaceWith(Routes.homeView);
    } else {
      // LoginView'e yönlendir
      _navigationService.replaceWith(Routes.firstPage);
    }
  }
}

import 'package:bootcamp_team_83_flutter/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:bootcamp_team_83_flutter/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/home_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:bootcamp_team_83_flutter/ui/views/login/login_view.dart';
import 'package:bootcamp_team_83_flutter/services/authentication_service.dart';
import 'package:bootcamp_team_83_flutter/ui/views/signup/signup_view.dart';
import 'package:bootcamp_team_83_flutter/services/firestore_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignupView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: FirestoreService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}

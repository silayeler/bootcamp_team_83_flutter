import 'package:bootcamp_team_83_flutter/services/chapter_service.dart';
import 'package:bootcamp_team_83_flutter/services/storage_service.dart';
import 'package:bootcamp_team_83_flutter/services/user_service.dart';
import 'package:bootcamp_team_83_flutter/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:bootcamp_team_83_flutter/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:bootcamp_team_83_flutter/ui/views/forms/chapter_form_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/forms/pathway_form_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/home_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/startup/startup_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/story/story_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:bootcamp_team_83_flutter/ui/views/login/login_view.dart';
import 'package:bootcamp_team_83_flutter/services/authentication_service.dart';
import 'package:bootcamp_team_83_flutter/ui/views/signup/signup_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignupView),
    MaterialRoute(page: StoryView),
    MaterialRoute(page: PathWayFormView),
    MaterialRoute(page: ChapterFormView),
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: ChapterService),
    LazySingleton(classType: StorageService),
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

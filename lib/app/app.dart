import 'package:bootcamp_team_83_flutter/services/ai_service.dart';
import 'package:bootcamp_team_83_flutter/services/chapter_service.dart';
import 'package:bootcamp_team_83_flutter/services/storage_service.dart';
import 'package:bootcamp_team_83_flutter/services/user_service.dart';
import 'package:bootcamp_team_83_flutter/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:bootcamp_team_83_flutter/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:bootcamp_team_83_flutter/ui/views/chapter/chapter_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/form/chapter_form_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/form/pathway_form_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/form/question_form_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/drawer/profile/profile_photo_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/home_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/onboardingscreen/first_page.dart';
import 'package:bootcamp_team_83_flutter/ui/views/pathway/pathway_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/question/question_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/question/question_viewmodel.dart';
import 'package:bootcamp_team_83_flutter/ui/views/startup/startup_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/story/story_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:bootcamp_team_83_flutter/ui/views/login/login_view.dart';
import 'package:bootcamp_team_83_flutter/services/authentication_service.dart';
import 'package:bootcamp_team_83_flutter/ui/views/signup/signup_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView, initial: true),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignupView),
    MaterialRoute(page: StoryView),

    MaterialRoute(page: ChapterView),
    MaterialRoute(page: PathwayView),
    MaterialRoute(page: QuestionView),

    MaterialRoute(page: ChapterFormView),
    MaterialRoute(page: PathwayFormView),
    MaterialRoute(page: QuestionFormView),
    MaterialRoute(page: FirstPage),
    MaterialRoute(page: ProfilePhotoView),

    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: ChapterService),
    LazySingleton(classType: StorageService),
    LazySingleton(classType: AIService),

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

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bootcamp_team_83_flutter/ui/views/chapter/chapter_view.dart'
    as _i6;
import 'package:bootcamp_team_83_flutter/ui/views/form/chapter_form_view.dart'
    as _i9;
import 'package:bootcamp_team_83_flutter/ui/views/form/pathway_form_view.dart'
    as _i10;
import 'package:bootcamp_team_83_flutter/ui/views/form/question_form_view.dart'
    as _i11;
import 'package:bootcamp_team_83_flutter/ui/views/home/drawer/profile/profile_photo_view.dart'
    as _i13;
import 'package:bootcamp_team_83_flutter/ui/views/home/home_view.dart' as _i2;
import 'package:bootcamp_team_83_flutter/ui/views/home/onboardingscreen/first_page.dart'
    as _i12;
import 'package:bootcamp_team_83_flutter/ui/views/login/login_view.dart' as _i3;
import 'package:bootcamp_team_83_flutter/ui/views/pathway/pathway_view.dart'
    as _i7;
import 'package:bootcamp_team_83_flutter/ui/views/question/question_view.dart'
    as _i8;
import 'package:bootcamp_team_83_flutter/ui/views/signup/signup_view.dart'
    as _i4;
import 'package:bootcamp_team_83_flutter/ui/views/story/story_view.dart' as _i5;
import 'package:flutter/material.dart' as _i14;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i15;

class Routes {
  static const homeView = '/';

  static const loginView = '/login-view';

  static const signupView = '/signup-view';

  static const storyView = '/story-view';

  static const chapterView = '/chapter-view';

  static const pathwayView = '/pathway-view';

  static const questionView = '/question-view';

  static const chapterFormView = '/chapter-form-view';

  static const pathwayFormView = '/pathway-form-view';

  static const questionFormView = '/question-form-view';

  static const firstPage = '/first-page';

  static const profilePhotoView = '/profile-photo-view';

  static const all = <String>{
    homeView,
    loginView,
    signupView,
    storyView,
    chapterView,
    pathwayView,
    questionView,
    chapterFormView,
    pathwayFormView,
    questionFormView,
    firstPage,
    profilePhotoView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i3.LoginView,
    ),
    _i1.RouteDef(
      Routes.signupView,
      page: _i4.SignupView,
    ),
    _i1.RouteDef(
      Routes.storyView,
      page: _i5.StoryView,
    ),
    _i1.RouteDef(
      Routes.chapterView,
      page: _i6.ChapterView,
    ),
    _i1.RouteDef(
      Routes.pathwayView,
      page: _i7.PathwayView,
    ),
    _i1.RouteDef(
      Routes.questionView,
      page: _i8.QuestionView,
    ),
    _i1.RouteDef(
      Routes.chapterFormView,
      page: _i9.ChapterFormView,
    ),
    _i1.RouteDef(
      Routes.pathwayFormView,
      page: _i10.PathwayFormView,
    ),
    _i1.RouteDef(
      Routes.questionFormView,
      page: _i11.QuestionFormView,
    ),
    _i1.RouteDef(
      Routes.firstPage,
      page: _i12.FirstPage,
    ),
    _i1.RouteDef(
      Routes.profilePhotoView,
      page: _i13.ProfilePhotoView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.LoginView(key: args.key),
        settings: data,
      );
    },
    _i4.SignupView: (data) {
      final args = data.getArgs<SignupViewArguments>(
        orElse: () => const SignupViewArguments(),
      );
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.SignupView(key: args.key),
        settings: data,
      );
    },
    _i5.StoryView: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.StoryView(),
        settings: data,
      );
    },
    _i6.ChapterView: (data) {
      final args = data.getArgs<ChapterViewArguments>(nullOk: false);
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i6.ChapterView(key: args.key, userId: args.userId),
        settings: data,
      );
    },
    _i7.PathwayView: (data) {
      final args = data.getArgs<PathwayViewArguments>(nullOk: false);
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.PathwayView(
            key: args.key, sectionId: args.sectionId, userId: args.userId),
        settings: data,
      );
    },
    _i8.QuestionView: (data) {
      final args = data.getArgs<QuestionViewArguments>(nullOk: false);
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i8.QuestionView(key: args.key, questions: args.questions),
        settings: data,
      );
    },
    _i9.ChapterFormView: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.ChapterFormView(),
        settings: data,
      );
    },
    _i10.PathwayFormView: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.PathwayFormView(),
        settings: data,
      );
    },
    _i11.QuestionFormView: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.QuestionFormView(),
        settings: data,
      );
    },
    _i12.FirstPage: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.FirstPage(),
        settings: data,
      );
    },
    _i13.ProfilePhotoView: (data) {
      final args = data.getArgs<ProfilePhotoViewArguments>(nullOk: false);
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i13.ProfilePhotoView(key: args.key, photoUrl: args.photoUrl),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class LoginViewArguments {
  const LoginViewArguments({this.key});

  final _i14.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant LoginViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class SignupViewArguments {
  const SignupViewArguments({this.key});

  final _i14.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant SignupViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ChapterViewArguments {
  const ChapterViewArguments({
    this.key,
    required this.userId,
  });

  final _i14.Key? key;

  final String userId;

  @override
  String toString() {
    return '{"key": "$key", "userId": "$userId"}';
  }

  @override
  bool operator ==(covariant ChapterViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.userId == userId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ userId.hashCode;
  }
}

class PathwayViewArguments {
  const PathwayViewArguments({
    this.key,
    required this.sectionId,
    required this.userId,
  });

  final _i14.Key? key;

  final String sectionId;

  final String userId;

  @override
  String toString() {
    return '{"key": "$key", "sectionId": "$sectionId", "userId": "$userId"}';
  }

  @override
  bool operator ==(covariant PathwayViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.sectionId == sectionId &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ sectionId.hashCode ^ userId.hashCode;
  }
}

class QuestionViewArguments {
  const QuestionViewArguments({
    this.key,
    required this.questions,
  });

  final _i14.Key? key;

  final List<Map<String, dynamic>> questions;

  @override
  String toString() {
    return '{"key": "$key", "questions": "$questions"}';
  }

  @override
  bool operator ==(covariant QuestionViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.questions == questions;
  }

  @override
  int get hashCode {
    return key.hashCode ^ questions.hashCode;
  }
}

class ProfilePhotoViewArguments {
  const ProfilePhotoViewArguments({
    this.key,
    required this.photoUrl,
  });

  final _i14.Key? key;

  final String photoUrl;

  @override
  String toString() {
    return '{"key": "$key", "photoUrl": "$photoUrl"}';
  }

  @override
  bool operator ==(covariant ProfilePhotoViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return key.hashCode ^ photoUrl.hashCode;
  }
}

extension NavigatorStateExtension on _i15.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView({
    _i14.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.loginView,
        arguments: LoginViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSignupView({
    _i14.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.signupView,
        arguments: SignupViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.storyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChapterView({
    _i14.Key? key,
    required String userId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.chapterView,
        arguments: ChapterViewArguments(key: key, userId: userId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPathwayView({
    _i14.Key? key,
    required String sectionId,
    required String userId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.pathwayView,
        arguments: PathwayViewArguments(
            key: key, sectionId: sectionId, userId: userId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToQuestionView({
    _i14.Key? key,
    required List<Map<String, dynamic>> questions,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.questionView,
        arguments: QuestionViewArguments(key: key, questions: questions),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChapterFormView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.chapterFormView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPathwayFormView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.pathwayFormView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToQuestionFormView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.questionFormView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFirstPage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.firstPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfilePhotoView({
    _i14.Key? key,
    required String photoUrl,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.profilePhotoView,
        arguments: ProfilePhotoViewArguments(key: key, photoUrl: photoUrl),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView({
    _i14.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.loginView,
        arguments: LoginViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSignupView({
    _i14.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.signupView,
        arguments: SignupViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.storyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChapterView({
    _i14.Key? key,
    required String userId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.chapterView,
        arguments: ChapterViewArguments(key: key, userId: userId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPathwayView({
    _i14.Key? key,
    required String sectionId,
    required String userId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.pathwayView,
        arguments: PathwayViewArguments(
            key: key, sectionId: sectionId, userId: userId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithQuestionView({
    _i14.Key? key,
    required List<Map<String, dynamic>> questions,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.questionView,
        arguments: QuestionViewArguments(key: key, questions: questions),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChapterFormView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.chapterFormView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPathwayFormView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.pathwayFormView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithQuestionFormView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.questionFormView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFirstPage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.firstPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfilePhotoView({
    _i14.Key? key,
    required String photoUrl,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.profilePhotoView,
        arguments: ProfilePhotoViewArguments(key: key, photoUrl: photoUrl),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}

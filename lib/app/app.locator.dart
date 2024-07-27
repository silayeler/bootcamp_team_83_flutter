// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:bootcamp_team_83_flutter/services/authentication_service.dart';
import 'package:bootcamp_team_83_flutter/services/chapter_service.dart';
import 'package:bootcamp_team_83_flutter/services/storage_service.dart';
import 'package:bootcamp_team_83_flutter/services/user_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_shared/stacked_shared.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
  // Register environments
  locator.registerEnvironment(
    environment: environment,
    environmentFilter: environmentFilter,
  );

  // Register dependencies
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => SnackbarService());

  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => StorageService());
  locator.registerLazySingleton(() => ChapterService());
}

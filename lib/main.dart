
import 'package:bootcamp_team_83_flutter/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bootcamp_team_83_flutter/app/app.bottomsheets.dart';
import 'package:bootcamp_team_83_flutter/app/app.dialogs.dart';
import 'package:bootcamp_team_83_flutter/app/app.locator.dart';
import 'package:bootcamp_team_83_flutter/app/app.router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  /*ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.courierPrimeTextTheme(baseTheme.textTheme),
    );
  }*/

  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.homeView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],


      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   textTheme: TextTheme(
      //     bodyLarge: GoogleFonts.courierPrime(
      //       textStyle: const TextStyle(fontSize: 16.0, color: Colors.white),
      //     ),
      //     bodyMedium: GoogleFonts.courierPrime(
      //       textStyle: const TextStyle(fontSize: 14.0, color: Colors.white),
      //     ),
      //     displayLarge: GoogleFonts.courierPrime(
      //       textStyle: const TextStyle(
      //           fontSize: 32.0,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.white),
      //     ),
      //     displayMedium: GoogleFonts.courierPrime(
      //       textStyle: const TextStyle(
      //           fontSize: 24.0,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.white),
      //     ),
      //     displaySmall: GoogleFonts.courierPrime(
      //       textStyle: const TextStyle(
      //           fontSize: 20.0,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.white),
      //     ),
      //   ),
      // ),
    );
  }
}

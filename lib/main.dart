import 'package:bootcamp_team_83_flutter/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked_services/stacked_services.dart';
=======
>>>>>>> 702b2a817d2274767e75a51103a9f43537e02c20
import 'package:bootcamp_team_83_flutter/app/app.bottomsheets.dart';
import 'package:bootcamp_team_83_flutter/app/app.dialogs.dart';
import 'package:bootcamp_team_83_flutter/app/app.locator.dart';
import 'package:bootcamp_team_83_flutter/app/app.router.dart';
<<<<<<< HEAD
=======
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked_services/stacked_services.dart';
>>>>>>> 702b2a817d2274767e75a51103a9f43537e02c20

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
<<<<<<< HEAD
  const MainApp({super.key});

  ThemeData _buildTheme(Brightness brightness) {
=======
  ThemeData _buildTheme(brightness) {
>>>>>>> 702b2a817d2274767e75a51103a9f43537e02c20
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.courierPrimeTextTheme(baseTheme.textTheme),
    );
  }

<<<<<<< HEAD
=======
  const MainApp({super.key});

>>>>>>> 702b2a817d2274767e75a51103a9f43537e02c20
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      initialRoute: Routes.homeView, // Ana sayfanızın başlangıç rotası
=======
      initialRoute: Routes.homeView,
>>>>>>> 702b2a817d2274767e75a51103a9f43537e02c20
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
<<<<<<< HEAD
      theme: _buildTheme(Brightness.light), // Temayı burada belirleyin
=======
      theme: _buildTheme(Brightness.light),

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
>>>>>>> 702b2a817d2274767e75a51103a9f43537e02c20
    );
  }
}

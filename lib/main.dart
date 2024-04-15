// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:stress_sheild/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:stress_sheild/router.dart';
//
//
//
// List<CameraDescription>? cameras;
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   cameras = await availableCameras();
//
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blueGrey,
//       ),
//
//       initialRoute: '/',
//       routes:AppRouter.routes,
//       // home: StreamBuilder(
//       //   stream: FirebaseAuth.instance.authStateChanges(),
//       //   builder: (context, snapshot) {
//       //     if (snapshot.hasData) {
//       //       return const HomeScreen();
//       //     } else {
//       //       return const WelcomeScreen();
//       //     }
//       //   },
//       // ),
//     );
//   }
// }


import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stress_sheild/feature/aiTherapyChatbot/screen/containertocreate.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/landing_home_page.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/screens/login_screen.dart';
import 'package:stress_sheild/feature/welcome_feature/screens/welcome_screen.dart';
import 'package:stress_sheild/router.dart';


import 'firebase_options.dart';

List<CameraDescription>? cameras;

Future<void> main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  cameras= await availableCameras();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Check if the user is already logged in
  User? user = FirebaseAuth.instance.currentUser;
  Widget initialScreen;
  if (user != null) {
    initialScreen = DummyContainer(); // User is already logged in
  } else {
    // Check if it's the user's first time opening the app
    bool isFirstTimeUser = await isFirstTimeUserCheck();
    if (isFirstTimeUser) {
      initialScreen = WelcomeScreen(); // Show splash screen for first-time users
    } else {
      initialScreen = LoginScreen(); // User is not logged in, show login page
    }
  }

  runApp(MyApp(initialScreen: initialScreen));
}

// Function to check if it's the user's first time opening the app
Future<bool> isFirstTimeUserCheck() async {
  // Initialize shared preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Check if the flag indicating first-time user exists
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  // If it's the first time, set the flag to false for future launches
  if (isFirstTime) {
    prefs.setBool('isFirstTime', false);
  }

  // Return the isFirstTime flag
  return isFirstTime;
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;
  const MyApp({required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes:AppRouter.routes,
    );
  }
}

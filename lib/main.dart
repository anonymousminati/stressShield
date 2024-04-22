//
// import 'package:camera/camera.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:stress_sheild/feature/aiTherapyChatbot/screen/containertocreate.dart';
// import 'package:stress_sheild/feature/home_and_mental_health_score/screens/landing_home_page.dart';
// import 'package:stress_sheild/feature/signIn_and_signUp/screens/login_screen.dart';
// import 'package:stress_sheild/feature/welcome_feature/screens/welcome_screen.dart';
// import 'package:stress_sheild/router.dart';
//
//
// import 'feature/home_and_mental_health_score/screens/customnavbar.dart';
// import 'firebase_options.dart';
//
// List<CameraDescription>? cameras;
//
// Future<void> main() async {
//   // Initialize Firebase
//   WidgetsFlutterBinding.ensureInitialized();
//   cameras= await availableCameras();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   // Check if the user is already logged in
//   User? user = FirebaseAuth.instance.currentUser;
//   Widget initialScreen;
//   if (user != null) {
//     initialScreen = BottomNavWithAnimations(); // User is already logged in
//   } else {
//     // Check if it's the user's first time opening the app
//     bool isFirstTimeUser = await isFirstTimeUserCheck();
//     if (isFirstTimeUser) {
//       // initialScreen = WelcomeScreen(); // Show splash screen for first-time users
//       initialScreen = WelcomeScreen(); // Show splash screen for first-time users
//     } else {
//       initialScreen = LoginScreen(); // User is not logged in, show login page
//     }
//   }
//
//   runApp(MyApp(initialScreen: initialScreen));
// }
//
// // Function to check if it's the user's first time opening the app
// Future<bool> isFirstTimeUserCheck() async {
//   // Initialize shared preferences
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//
//   // Check if the flag indicating first-time user exists
//   bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
//
//   // If it's the first time, set the flag to false for future launches
//   if (isFirstTime) {
//     prefs.setBool('isFirstTime', false);
//   }
//
//   // Return the isFirstTime flag
//   return isFirstTime;
// }
//
// class MyApp extends StatelessWidget {
//   final Widget initialScreen;
//   const MyApp({required this.initialScreen});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       routes:AppRouter.routes,
//     );
//   }
// }

// import 'dart:async';
// import 'dart:isolate';

import 'dart:async';
import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/customnavbar.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/screens/login_screen.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/services/firebase_auth_service.dart';
import 'package:stress_sheild/feature/welcome_feature/screens/welcome_screen.dart';
import 'package:stress_sheild/router.dart';

import 'firebase_options.dart';

List<CameraDescription>? cameras;

Future<void> main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Check if the user is already logged in
  User? user = FirebaseAuth.instance.currentUser;
  // Widget initialScreen;
  if (user != null) {
    // Check if the user exists in the Firestore database
    bool userExists = await isUserExistsInDatabase(user.uid);
    if (userExists) {
      AppRouter.initialScreen =
          BottomNavWithAnimations(); // User is already logged in but not in the database
    } else {
      AppRouter.initialScreen =
          BottomNavWithAnimations(); // User is already logged in and exists in the database
    }
  } else {
    // Check if it's the user's first time opening the app
    bool isFirstTimeUser = await isFirstTimeUserCheck();
    if (isFirstTimeUser) {
      AppRouter.initialScreen =
          WelcomeScreen(); // Show splash screen for first-time users
    } else {
      // Check if the user is registered in the database
      bool isRegisteredUser = await isRegisteredUserInDatabase();
      if (isRegisteredUser) {
        AppRouter.initialScreen =
            LoginScreen(); // User is not logged in but registered in the database
      } else {
        AppRouter.initialScreen =
            LoginScreen(); // User is not logged in and not registered, show login page
      }
    }
  }

  runApp(MyApp());
  startBackgroundTimer();
}

Future<void> startBackgroundTimer() async {
  UserInformation _userInformation = Get.put(UserInformation());
  ReceivePort receivePort = ReceivePort();
  await Isolate.spawn(startTimer, receivePort.sendPort);

  receivePort.listen((data) {
    if (data % 9 == 0) {
      //convert data into minutes and update the user's mindfulness score
      _userInformation.mindfulness_score.value = data ~/ 60;
    }
    print('Time elapsed: ${data ~/ 60} minutes');
    // Here you can store the elapsed time to a database or shared preferences
  });
}

void startTimer(SendPort sendPort) {
  int counter = 0;
  Timer.periodic(Duration(seconds: 1), (Timer t) {
    counter++;
    sendPort.send(counter);
  });
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

// Function to check if the user exists in the Firestore database
Future<bool> isUserExistsInDatabase(String userId) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return userSnapshot.exists;
  } catch (e) {
    print('Error checking user existence: $e');
    return false;
  }
}

// Function to check if the user is registered in the database
Future<bool> isRegisteredUserInDatabase() async {
  // Implement your logic to check if the user is registered in the database
  // For example, you can check if there are any documents in the users collection
  try {
    QuerySnapshot<Map<String, dynamic>> usersSnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    return usersSnapshot.docs.isNotEmpty;
  } catch (e) {
    print('Error checking registered user in database: $e');
    return false;
  }
}

class MyApp extends StatelessWidget {
  // final Widget initialScreen;
  // const MyApp({required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: AppRouter.routes,
    );
  }
}

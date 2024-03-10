import 'package:flutter/material.dart';
import 'package:stress_sheild/feature/aiTherapyChatbot/screen/containertocreate.dart';
import 'package:stress_sheild/feature/aiTherapyChatbot/screen/faceDetection.dart';
import 'package:stress_sheild/feature/mindful_resources/screens/article.dart';
import 'package:stress_sheild/feature/mindful_resources/screens/our_courses.dart';
import 'package:stress_sheild/feature/profile/acountSettings.dart';
import 'package:stress_sheild/feature/profile/personalInformation.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/screens/changePassword.dart';
import 'package:stress_sheild/feature/smart_notification/screens/notification_landingPage.dart';
import 'feature/home_and_mental_health_score/screens/landing_home_page.dart';
import 'feature/mindful_resources/screens/our_article.dart';
import 'feature/signIn_and_signUp/screens/signInwelcome_screen.dart';
import 'feature/splash_and_loading/screens/loading_screen_interactive.dart';
import 'feature/splash_and_loading/screens/loading_screen_quote.dart';
import 'feature/splash_and_loading/screens/splash.dart';
import 'feature/welcome_feature/screens/welcome_screen.dart';


class AppRouter {

  static final routes = {
    '/': (BuildContext context) => WelcomeScreen(),
    // '/': (BuildContext context) => DummyContainer(),
    // '/': (BuildContext context) => FaceDetectionLandingPage(),
    'landingHomePage': (BuildContext context) => LandingHomePage(),
    'welcome': (BuildContext context) => WelcomeScreen(),
    'loading': (BuildContext context) => LoadingScreenInteractive(),
    'splash': (BuildContext context) => SplashScreen(),
    'loadingQuote': (BuildContext context) => LoadingScreenQuote(),
    'login': (BuildContext context) => SignInWelcomeScreen(),
    'article': (BuildContext context) =>  Article(),
    // 'courses': (BuildContext context) => Course(course: null),
    'ourArticle': (BuildContext context) => OurArticle(),
    'ourCourses': (BuildContext context) => OurCourses(),
    'notification': (BuildContext context) => NotificationLandingPage(),
    'accountSettings': (BuildContext context) => AccountSettings(),
    'personalInformation': (BuildContext context) => PersonalInformation(),
    'changePassword': (BuildContext context) => ChangePasswordScreen(),
  };
}

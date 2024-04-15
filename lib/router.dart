import 'package:flutter/material.dart';
import 'package:stress_sheild/feature/aiTherapyChatbot/screen/containertocreate.dart';
import 'package:stress_sheild/feature/aiTherapyChatbot/screen/faceDetection.dart';
import 'package:stress_sheild/feature/audio_therapy/music_player.dart';
import 'package:stress_sheild/feature/chatBot/screens/chatScreen.dart';
import 'package:stress_sheild/feature/communityChat/pages/community_chat_landing_page.dart';
import 'package:stress_sheild/feature/mindful_resources/screens/article.dart';
import 'package:stress_sheild/feature/mindful_resources/screens/our_courses.dart';
import 'package:stress_sheild/feature/profile/acountSettings.dart';
import 'package:stress_sheild/feature/profile/personalInformation.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/screens/changePassword.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/screens/forgot_password.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/screens/login_screen.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/screens/otpverification.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/screens/signup_screen.dart';
import 'package:stress_sheild/feature/sleep_quality/screens/sleepQualityLandingPage.dart';
import 'package:stress_sheild/feature/smart_notification/screens/notification_landingPage.dart';
import 'feature/home_and_mental_health_score/screens/landing_home_page.dart';
import 'feature/mindful_resources/screens/our_article.dart';
import 'feature/signIn_and_signUp/screens/authenticationUI.dart';
import 'feature/signIn_and_signUp/screens/signInwelcome_screen.dart';
import 'feature/splash_and_loading/screens/loading_screen_interactive.dart';
import 'feature/splash_and_loading/screens/loading_screen_quote.dart';
import 'feature/splash_and_loading/screens/splash.dart';
import 'feature/welcome_feature/screens/welcome_screen.dart';


class AppRouter {

  static final routes = {
    // '/': (BuildContext context) => WelcomeScreen(),
    // '/': (BuildContext context) => LandingHomePage(),
    '/': (BuildContext context) => MusicPlay(),
    'landingHomePage': (BuildContext context) => LandingHomePage(),
    'welcome': (BuildContext context) => WelcomeScreen(),
    'loading': (BuildContext context) => LoadingScreenInteractive(),
    'splash': (BuildContext context) => SplashScreen(),
    'loadingQuote': (BuildContext context) => LoadingScreenQuote(),
    'login': (BuildContext context) => LoginScreen(),
    'register': (BuildContext context) => SignUpScreen(),

    'authUI': (BuildContext context) => AuthenticationUI(),
    // 'article': (BuildContext context) =>  Article(),
    // 'courses': (BuildContext context) => Course(course: null),
    'forgotPassword': (BuildContext context) => ForgotPassword(),
    'ourArticle': (BuildContext context) => OurArticle(),
    'ourCourses': (BuildContext context) => OurCourses(),
    'notification': (BuildContext context) => NotificationLandingPage(),
    'accountSettings': (BuildContext context) => AccountSettings(),
    'personalInformation': (BuildContext context) => PersonalInformation(),
    'changePassword': (BuildContext context) => ChangePasswordScreen(),
    'otpverification':  (BuildContext context) => OtpVerificationPage(),
  };
}

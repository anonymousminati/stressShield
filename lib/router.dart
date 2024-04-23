import 'package:flutter/material.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/customnavbar.dart';
import 'package:stress_sheild/feature/mindful_resources/screens/our_courses.dart';
import 'package:stress_sheild/feature/profile/acountSettings.dart';
import 'package:stress_sheild/feature/profile/feed_back.dart';
import 'package:stress_sheild/feature/profile/personalInformation.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/screens/changePassword.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/screens/forgot_password.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/screens/login_screen.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/screens/otpverification.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/screens/signup_screen.dart';
import 'package:stress_sheild/feature/smart_notification/screens/notification_landingPage.dart';
import 'package:stress_sheild/feature/smart_notification/screens/notification_page.dart';
import 'feature/mindful_resources/screens/our_article.dart';
import 'feature/signIn_and_signUp/screens/authenticationUI.dart';
import 'feature/splash_and_loading/screens/loading_screen_interactive.dart';
import 'feature/splash_and_loading/screens/loading_screen_quote.dart';
import 'feature/splash_and_loading/screens/splash.dart';
import 'feature/welcome_feature/screens/welcome_screen.dart';

class AppRouter {
  static Widget initialScreen = Container();

  static final routes = {
    // '/': (BuildContext context) => FeedbackForm(),
    '/': (BuildContext context) => initialScreen,

    // '/': (BuildContext context) => MusicPlay(),
    'landingHomePage': (BuildContext context) => BottomNavWithAnimations(),
    'welcome': (BuildContext context) => WelcomeScreen(),
    'loading': (BuildContext context) => LoadingScreenInteractive(),
    'splash': (BuildContext context) => SplashScreen(),
    'loadingQuote': (BuildContext context) => LoadingScreenQuote(),
    'login': (BuildContext context) => LoginScreen(),
    'register': (BuildContext context) => SignUpScreen(),
    // 'notificationpage': (BuildContext context) => NotificationPage(),
    'authUI': (BuildContext context) => AuthenticationUI(),
    // 'article': (BuildContext context) =>  Article(),
    // 'courses': (BuildContext context) => Course(course: null),
    'forgotPassword': (BuildContext context) => ForgotPassword(),
    'ourArticle': (BuildContext context) => OurArticle(),
    'ourCourses': (BuildContext context) => OurCourses(),
    // 'notification': (BuildContext context) => NotificationLandingPage(),
    'notification': (BuildContext context) => NotificationPage(),
    'accountSettings': (BuildContext context) => AccountSettings(),
    'personalInformation': (BuildContext context) => PersonalInformation(),
    'changePassword': (BuildContext context) => ChangePasswordScreen(),
    'otpverification': (BuildContext context) => OtpVerificationPage(),
  };
}

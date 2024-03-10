import 'package:flutter/material.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/screens/signInwelcome_screen.dart';
import 'package:stress_sheild/feature/welcome_feature/widgets/welcome_screen_reusable_steps.dart';

class WelcomeScreen1 extends StatefulWidget {
  WelcomeScreen1({Key? key});

  @override
  _WelcomeScreen1State createState() => _WelcomeScreen1State();
}

class _WelcomeScreen1State extends State<WelcomeScreen1> {
  late PageController _pageController;
  late int currentPage;

  late List<ReusableStepsScreen> stepsList;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    currentPage = 0;

    stepsList = [
      ReusableStepsScreen(
        onPress: () => _handleNextPressed(),
        index: 0,
        text: ['Personalize Your Mental ', 'Health State ', 'With AI'],
        colors: [Color(0xFF4F3422), Color(0xFF9BB168), Color(0xFF4F3422)],
        fontSizes: [30, 30, 30],
      ),
      ReusableStepsScreen(
        onPress: () => _handleNextPressed(),
        index: 1,
        text: ['Intelligent ', 'Mood Tracking ', 'Emotion Insights'],
        colors: [Color(0xFF4F3422), Color(0xFF4F3422), Color(0xFF4F3422)],
        fontSizes: [30, 30, 30],
      ),
      ReusableStepsScreen(
        onPress: () => _handleNextPressed(),
        index: 2,
        text: ['AI  ', 'Mental ', 'Journaling & AI Therapy Chatbot'],
        colors: [Color(0xFF4F3422), Color(0xFF736B66), Color(0xFF4F3422)],
        fontSizes: [30, 30, 30],
      ),
      ReusableStepsScreen(
        onPress: () => _handleNextPressed(),
        index: 3,
        text: ['Mindful Resources ', 'Resources ', 'That Makes You Happy'],
        colors: [Color(0xFF4F3422), Color(0xFFFFBD1A), Color(0xFF4F3422)],
        fontSizes: [30, 30, 30],
      ),
      ReusableStepsScreen(
        onPress: () => _handleNextPressed(),
        index: 4,
        text: ['Loving & Supportive ', 'Community'],
        colors: [Color(0xFF4F3422), Color(0xFFA694F5)],
        fontSizes: [30, 30],
      ),
    ];
  }

  void _handleNextPressed() {
    if (currentPage < stepsList.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      // Check if the user is logged in
      // bool isLoggedIn = /* Replace this with your authentication check */ false;
      //
      // if (isLoggedIn) {
      //   // If logged in, navigate to home and mental health page
      //   // Navigator.pushReplacementNamed(context, '/homeAndMentalHealthPage');
      // } else {
      //   // If not logged in, navigate to the sign-in page
      //   // Navigator.pushReplacementNamed(context, '/signIn');
      // }
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SignInWelcomeScreen();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: PageView.builder(
            controller: _pageController,
            itemCount: stepsList.length,
            itemBuilder: (context, index) {
              return stepsList[index];
            },
            onPageChanged: (int page) {
              setState(() {
                currentPage = page;
              });
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stress_sheild/feature/welcome_feature/screens/welcome_step1.dart';
import 'package:stress_sheild/global_widgets/reusable_material_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 24.0,
                ),
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Color(0xFF4E3321),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'images/splashsvg.png',
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Welcome to the ultimate StressShield Kit!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF4E3321),
                    fontSize: 40,
                    fontFamily: GoogleFonts.urbanist().fontFamily,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Your mindful mental health companion for everyone, anywhere 🍃',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF736A66),
                    fontSize: 20,
                    fontFamily: GoogleFonts.urbanist().fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Image.asset(
                  'images/welcome.png',
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
                SizedBox(
                  height: 24,
                ),
                //create a button for get started and add a navigation to the next screen
                ReusableButton(
                  text: 'Get Started',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return WelcomeScreen1();
                    }));
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                //already have an account? sign in
              ],
            ),
          ),
        )
      ],
    )));
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/customnavbar.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/landing_home_page.dart';
import 'dart:math';

//create a new stateless widget called LoadingScreenQuote it should return Scafold with body showing motivation quotes every time the app is loading . alsoo background should have funky colors for modern look
class LoadingScreenQuote extends StatelessWidget {
  LoadingScreenQuote({Key? key}) : super(key: key);
//create a list quotes
  final List<String> quotes = [
    "Whether you think you can- or think you can't ..you're right so think wisely",
    "The words you consistently select will shape your destiny",
    "Do what you can,with what you have, where you are",
    "Fall seven times, rise eight",
    "The key to getting what you want is the 'willingness' to do whatever it takes",
    "If your thoughts don't change, your result won't change",
    "There is no such thing as 'failures' - there are only results, some more successful than others",
    "It'll be worth it,though, in the end. Fighting for a lifetime of this",
    "One person with a commitment is worth more than 100 people who have only an interest",
    "You can get everything in life you want if you'll just help enough other people get what they want"
  ];
  @override
  Widget build(BuildContext context) {
    int randomIndex = Random().nextInt(quotes.length);
    //create a timer for 5second after that redirect to homescreen
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavWithAnimations(),
        ),
      );
    });
    return Scaffold(
      backgroundColor: Color(0xFFEC7D1C),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'images/splashsvg.png',
              width: 100,
            ),
            Text(
              quotes[randomIndex],
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.urbanist().fontFamily,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            // Text(
            //   '- Albert Einstein',
            //   style: TextStyle(
            //     fontSize: 20.0,
            //     fontWeight: GoogleFonts.urbanist(
            //       fontWeight: FontWeight.w600,
            //     ).fontWeight,
            //     color: Colors.white,
            //     fontFamily: GoogleFonts.urbanist().fontFamily,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

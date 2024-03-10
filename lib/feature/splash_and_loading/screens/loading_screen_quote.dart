import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/landing_home_page.dart';

//create a new stateless widget called LoadingScreenQuote it should return Scafold with body showing motivation quotes every time the app is loading . alsoo background should have funky colors for modern look
class LoadingScreenQuote extends StatelessWidget {
  LoadingScreenQuote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //create a timer for 5second after that redirect to homescreen
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LandingHomePage(),
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
              '“In the midst of winter, I found there was within me an invincible summer.”',
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
            Text(
              '- Albert Einstein',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                ).fontWeight,
                color: Colors.white,
                fontFamily: GoogleFonts.urbanist().fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

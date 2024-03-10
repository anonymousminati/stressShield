import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/splashsvg.png',
                width: MediaQuery.of(context).size.width * 0.8,
              ),
              const SizedBox(height: 20),
              Text(
                'Stress Shield',
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF53A157),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

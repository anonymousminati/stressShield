import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stress_sheild/global_widgets/fadeanimationtest.dart';

class AuthenticationUI extends StatefulWidget {
  const AuthenticationUI({super.key});

  @override
  State<AuthenticationUI> createState() => _AuthenticationUIState();
}

class _AuthenticationUIState extends State<AuthenticationUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "images/background.png",
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              )),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: SizedBox(
              child: Column(
                children: [
                  FadeInAnimation(
                      delay: 1,
                      child: Image.asset(
                        "images/splashsvg.png",
                        height: 200,
                        width: 500,
                      )),
                  FadeInAnimation(
                    delay: 1.5,
                    child: Text(
                      "StressShield",
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Column(
                    children: [
                      FadeInAnimation(
                        delay: 2.5,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'register');
                            // Add onPressed action for the first button
                          },
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(
                                BorderSide(color: Colors.black)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            fixedSize:
                                MaterialStateProperty.all(Size.fromWidth(370)),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(vertical: 20)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Urbanist-SemiBold",
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10), // Add spacing between buttons
                      FadeInAnimation(
                        delay: 2.5,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'login');
                            // Add onPressed action for the second button
                          },
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(
                                BorderSide(color: Colors.blue)),
                            // Example different color
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            fixedSize:
                                MaterialStateProperty.all(Size.fromWidth(370)),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(vertical: 20)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          child: Text(
                            "Login", // Example different text
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Urbanist-SemiBold",
                              fontWeight: FontWeight.bold,
                              color: Colors.blue, // Example different color
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

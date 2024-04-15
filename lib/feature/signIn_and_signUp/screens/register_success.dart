
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:stress_sheild/global_widgets/common.dart';
import 'package:stress_sheild/global_widgets/custom_widgets.dart';
import 'package:stress_sheild/global_widgets/fadeanimationtest.dart';

class RegisterSuccessPage extends StatefulWidget {
  const RegisterSuccessPage({super.key});

  @override
  State<RegisterSuccessPage> createState() => _RegisterSuccessPageState();
}

class _RegisterSuccessPageState extends State<RegisterSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFFE8ECF4),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              LottieBuilder.asset("assets/lottie/ticker.json"),
              FadeInAnimation(
                delay: 1,
                child: Text(
                  "Register Successfuly",
                  style: Common().titelTheme,
                ),
              ),

              SizedBox(
                height: 30,
              ),
              FadeInAnimation(
                delay: 2,
                child: CustomElevatedButton(
                  message: "Back to Login",
                  function: () {
                    Navigator.pushNamed(context, 'login');
                  },
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

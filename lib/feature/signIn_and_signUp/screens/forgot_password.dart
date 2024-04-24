import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stress_sheild/global_widgets/common.dart';
import 'package:stress_sheild/global_widgets/custom_widgets.dart';
import 'package:stress_sheild/global_widgets/fadeanimationtest.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFFE8ECF4),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInAnimation(
                  delay: 1,
                  child: IconButton(
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                      icon: const Icon(
                        CupertinoIcons.back,
                        size: 35,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInAnimation(
                        delay: 1.3,
                        child: Text(
                          "Forgot Password?",
                          style: Common().titelTheme,
                        ),
                      ),
                      FadeInAnimation(
                        delay: 1.6,
                        child: Text(
                          "Don't worry! It occurs. Please enter the email address linked with your account.",
                          style: Common()
                              .mediumTheme
                              .copyWith(color: Colors.black45),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    child: Column(
                      children: [
                        FadeInAnimation(
                          delay: 1.9,
                          child: const CustomTextFormField(
                            hinttext: 'Enter your email',
                            obsecuretext: false,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FadeInAnimation(
                          delay: 2.1,
                          child: CustomElevatedButton(
                            message: "Send Code ",
                            function: () {
                              Navigator.pushNamed(context, 'otpverification');
                            },
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                FadeInAnimation(
                  delay: 2.4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have an account?",
                          style: Common().hinttext,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                'register',
                              );
                            },
                            child: Text(
                              "Register Now",
                              style: Common().mediumTheme,
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

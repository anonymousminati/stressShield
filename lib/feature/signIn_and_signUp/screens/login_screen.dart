import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/screens/signup_screen.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/services/firebase_auth_service.dart';
import 'package:stress_sheild/feature/splash_and_loading/screens/loading_screen_quote.dart';
import 'package:stress_sheild/global_widgets/custom_widgets.dart';
import 'package:stress_sheild/global_widgets/fadeanimationtest.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final UserInformation _userInformation = Get.put(UserInformation());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Future<void> _login() async {
    //  The else part is not working in the video because we have
    //  enclosed it in the try catch block. Once we have error in
    // login the firebase exception is thrown and the codeblock after that
    // error is skiped and code of catch block is executed.
    // if we want our else part to be executed we need to get rid from
    // this try catch or add that code in catch block.

    try {
      await FirebaseAuthService().signInWithEmailAndPassword(
          _emailController.text.trim(), _passwordController.text.trim());
      if (FirebaseAuth.instance.currentUser != null) {
        // if (!mounted) return;
        _userInformation.fetchUserInformation();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            // builder: (context) => BottomNavWithAnimations(),
            builder: (context) => LoadingScreenQuote(),
          ),
          (route) => false,
        );
      }

      //  This code is gone inside the catch block
      // which is executed only when we have firebaseexception
      //  else {
      //   showDialog(
      //       context: context,
      //       builder: (context) => AlertDialog(
      //               title: Text(
      //                   " Invalid Username or password. Please register again or make sure that username and password is correct"),
      //               actions: [
      //                 ElevatedButton(
      //                   child: Text("Register Now"),
      //                   onPressed: () {
      //                     Navigator.push(
      //                         context,
      //                         MaterialPageRoute(
      //                             builder: (context) =>
      //                                 SignUpScreen()));
      //                   },
      //                 )
      //               ]));

      // }
    } on FirebaseException catch (e) {
      debugPrint("error is ${e.message}");

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  title: const Text(
                      " Invalid Username or password. Please register again or make sure that username and password is correct"),
                  actions: [
                    ElevatedButton(
                      child: const Text("Register Now"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                    )
                  ]));
    }

// Navigator.push(context,
//     MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  // Future<void> _login() async {
  //   try {
  //     final String email = _emailController.text.trim();
  //     final String password = _passwordController.text.trim();
  //
  //
  //
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //
  //     Navigator.pushNamed(context, '/loadingScreenQuote');
  //   } catch (e) {
  //     print("Login failed: $e");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Login failed: ${e.toString()}'),
  //         duration: Duration(seconds: 3),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FadeInAnimation(
                      delay: 1,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'authUI');
                        },
                        icon: const Icon(
                          CupertinoIcons.back,
                          size: 35,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInAnimation(
                            delay: 1.3,
                            child: Text(
                              "Welcome back! Glad ",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: "Urbanist",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          FadeInAnimation(
                            delay: 1.6,
                            child: Text(
                              "to see you, Again!",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: "Urbanist",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
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
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(18),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: 'Enter your email',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!EmailValidator.validate(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FadeInAnimation(
                              delay: 2.2,
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(18),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: 'Enter your password',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  suffixIcon: IconButton(
                                    onPressed: _togglePasswordVisibility,
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            FadeInAnimation(
                              delay: 2.5,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      'forgotPassword',
                                    );
                                  },
                                  child: Text(
                                    "Forget Password?",
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            FadeInAnimation(
                              delay: 2.8,
                              child: CustomElevatedButton(
                                message: "Login",
                                function: _login,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: Column(
                          children: [
                            FadeInAnimation(
                              delay: 2.2,
                              child: Text(
                                "Or Log with",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            FadeInAnimation(
                              delay: 2.4,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                  right: 30,
                                  left: 30,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: IconButton(
                                        icon: const Icon(
                                          FontAwesomeIcons.google,
                                          // color: Colors.blue,
                                        ),
                                        onPressed: () async {
                                          await FirebaseAuthService()
                                              .signInWithGoogle();
                                          print('stopped this');

                                          if (FirebaseAuth
                                                  .instance.currentUser !=
                                              null) {
                                            if (!mounted) {
                                              print('stopped');
                                              return;
                                            }
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoadingScreenQuote()));
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FadeInAnimation(
                      delay: 2.8,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Don’t have an account?",
                              style: TextStyle(
                                color: Colors.black,
                              ),
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
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

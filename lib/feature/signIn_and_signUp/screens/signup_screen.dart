import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/screens/newUserInformation.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/services/firebase_auth_service.dart';
import 'package:stress_sheild/global_widgets/common.dart';
import 'package:stress_sheild/global_widgets/custom_widgets.dart';
import 'package:stress_sheild/global_widgets/fadeanimationtest.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInAnimation(
                          delay: 0.6,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
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
                                delay: 0.9,
                                child: Text(
                                  "Hello! Register to get ",
                                  style: Common().titelTheme,
                                ),
                              ),
                              FadeInAnimation(
                                delay: 1.2,
                                child: Text(
                                  "started",
                                  style: Common().titelTheme,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  hinttext: 'Username',
                                  obsecuretext: false,
                                  controller: _usernameController,
                                  // Update this line
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a username';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                CustomTextFormField(
                                  hinttext: 'Email',
                                  obsecuretext: false,
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter an email';
                                    }
                                    if (!EmailValidator.validate(value)) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),

                                Stack(
                                  children: [
                                    CustomTextFormField(
                                      hinttext: 'Password',
                                      obsecuretext: _isPasswordHidden,
                                      controller: _passwordController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a password';
                                        }
                                        if (!RegExp(
                                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                            .hasMatch(value)) {
                                          return 'Password must contain at least one uppercase letter, one lowercase letter, one digit, one special character, and have a minimum length of 8 characters';
                                        }
                                        return null;
                                      },
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 12,
                                      child: IconButton(
                                        icon: Icon(
                                          _isPasswordHidden
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isPasswordHidden =
                                            !_isPasswordHidden;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Stack(
                                  children: [
                                    CustomTextFormField(
                                      hinttext: 'Confirm password',
                                      obsecuretext: _isConfirmPasswordHidden,
                                      controller: _confirmPasswordController,
                                      validator: (value) {
                                        if (value !=
                                            _passwordController.text) {
                                          return 'Passwords do not match';
                                        }
                                        return null;
                                      },
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 12,
                                      child: IconButton(
                                        icon: Icon(
                                          _isConfirmPasswordHidden
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isConfirmPasswordHidden =
                                            !_isConfirmPasswordHidden;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                CustomElevatedButton(
                                  message: "Register",
                                  function: _registerUser,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                FadeInAnimation(
                                  delay: 3.2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10, right: 30, left: 30),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            height: 50,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black, width: 1),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: IconButton(
                                              icon: const Icon(
                                                FontAwesomeIcons.facebookF,
                                                color: Colors.blue,
                                              ),
                                              onPressed: () {},
                                            )),
                                        Container(
                                          height: 50,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black, width: 1),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: IconButton(
                                              icon: const Icon(
                                                FontAwesomeIcons.google,
                                                // color: Colors.blue,
                                              ),
                                              onPressed: () async {
                                                try {
                                                  // Register the user with Google
                                                  User? user = await FirebaseAuthService().signInWithGoogle();
                                                  String? emailId = user!.email;

                                                  if (user != null) {
                                                    // User successfully signed in with Google,
                                                    // Navigate to UserInfoPage
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => UserInfoPage(uid: user.uid, emailId: emailId.toString(),),
                                                      ),
                                                    );
                                                  } else {
                                                    // Handle the case where Google sign-in failed
                                                  }
                                                } catch (e) {
                                                  // Handle any errors that occur during Google sign-in
                                                  print("Error signing in with Google: $e");
                                                }
                                              }

                                          ),
                                        ),
                                        Container(
                                            height: 50,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black, width: 1),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: IconButton(
                                              icon: const Icon(
                                                FontAwesomeIcons.apple,
                                                // color: Colors.blue,
                                              ),
                                              onPressed: () {},
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                FadeInAnimation(
                                  delay: 2.8,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 60.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Already have an Account?",
                                          style: Common().hinttext,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              'login',
                                            );
                                          },
                                          child: Text(
                                            "Login",
                                            style: Common().mediumTheme,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _registerUser() async {
    try {
      if (_formKey.currentState!.validate()) {
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': _usernameController.text,
          'email': _emailController.text,
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserInfoPage(uid: userCredential.user!.uid , emailId:_emailController.text.trim()),
          ),
        );

      }
    } catch (e) {
      print("Error during registration: $e");
    }
  }
}


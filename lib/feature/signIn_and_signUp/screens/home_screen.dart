import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/screens/signInwelcome_screen.dart';
import 'package:stress_sheild/feature/welcome_feature/screens/welcome_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String? userName = FirebaseAuth.instance.currentUser?.displayName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Homepage"),
      ),
      body: Column(
        children: [
          Text("Hello $userName"),
          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (!mounted) return;
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SignInWelcomeScreen();
                }));
              },
              child: const Text("Sign Out"))
        ],
      ),
    );
  }
}

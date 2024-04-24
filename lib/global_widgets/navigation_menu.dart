import 'package:flutter/material.dart';
import 'package:stress_sheild/feature/communityChat/pages/community_chat_landing_page.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/customnavbar.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/landing_home_page.dart';
import 'package:stress_sheild/feature/profile/acountSettings.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BottomNavWithAnimations()));
              },
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: IconButton(
              icon: Icon(Icons.chat),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CommunityChatLandingPage()));
              },
            ),
            label: 'chat',
          ),
          NavigationDestination(
            icon: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AccountSettings()));
              },
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:stress_sheild/feature/chatBot/screens/chatScreen.dart';
import 'package:stress_sheild/feature/communityChat/pages/profile_page.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/landing_home_page.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/nav_item_mode.dart';
import 'package:stress_sheild/feature/profile/acountSettings.dart';



const Color bottomNavBgColor = Color(0xFF4F3422);

class BottomNavWithAnimations extends StatefulWidget {
  const BottomNavWithAnimations({super.key});

  @override
  State<BottomNavWithAnimations> createState() =>
      _BottomNavWithAnimationsState();
}

class _BottomNavWithAnimationsState extends State<BottomNavWithAnimations> {
  List<SMIBool> riveIconInputs = [];
  List<StateMachineController?> controllers=[];
  int selectedNavIndex = 0;
  List<Widget> pages=[LandingHomePage(),Center(child: Text('community'),) ,Center(child: Text('search'),)  , AccountSettings()];

  void animateTheIcon(int index) {
    setState(() {
      // Update the selectedNavIndex before animating the icon
      selectedNavIndex = index;
    });

    // Animate the icon based on the updated selectedNavIndex
    if (selectedNavIndex >= 0 && selectedNavIndex < riveIconInputs.length) {
      riveIconInputs[selectedNavIndex].change(true);
      Future.delayed(Duration(seconds: 1), () {
        riveIconInputs[selectedNavIndex].change(false);
      });
    }
  }

  void riveOnInIt(Artboard artboard, {required String stateMachineName}) {
    StateMachineController? controller =
    StateMachineController.fromArtboard(artboard, stateMachineName);

    artboard.addController(controller!);
    controllers.add(controller);

    riveIconInputs.add(controller.findInput<bool>('active') as SMIBool);
  }

  @override
  void dispose() {
    for(var controller in controllers){
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedNavIndex,
        children: pages,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.only(left: 24,right: 24, bottom: 24,top:12 ),
          decoration: BoxDecoration(
            color: bottomNavBgColor,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: bottomNavBgColor.withOpacity(0.3),
                offset: Offset(0, 20),
                blurRadius: 20,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(bottomNavItems.length, (index) {
              final riveIcon = bottomNavItems[index].rive;
              return GestureDetector(
                onTap: () {
                  animateTheIcon(index);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBar(isActive: selectedNavIndex == index),
                    SizedBox(
                      height: 36,
                      width: 36,
                      child: Opacity(
                        opacity: selectedNavIndex == index ? 1 : 0.5,
                        child: RiveAnimation.asset(
                          riveIcon.src,
                          artboard: riveIcon.artboard,
                          onInit: (artboard) {
                            riveOnInIt(artboard,
                                stateMachineName: riveIcon.stateMachine);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key, required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(microseconds: 100),
      margin: EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive? 20:0,
      decoration: BoxDecoration(
          color: Color(0xFF81B4FF),
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
    );
  }
}

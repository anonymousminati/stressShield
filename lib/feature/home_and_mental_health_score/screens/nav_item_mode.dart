import 'package:stress_sheild/model/rive_model.dart';

class NavItemModel {
  final String title;
  final RiveModel rive;

  NavItemModel({required this.title, required this.rive});
}

List<NavItemModel> bottomNavItems = [
  NavItemModel(
    title: "Home",
    rive: RiveModel(
        src: "assets/rive/riveicons.riv",
        artboard: "HOME",
        stateMachine: "HOME_interactivity"),
  ),
  NavItemModel(
    title: "CHAT",
    rive: RiveModel(
        src: "assets/rive/riveicons.riv",
        artboard: "CHAT",
        stateMachine: "CHAT_Interactivity"),
  ),
  NavItemModel(
    title: "Timer",
    rive: RiveModel(
        src: "assets/rive/riveicons.riv",
        artboard: "TIMER",
        stateMachine: "TIMER_Interactivity"),
  ),
  NavItemModel(
    title: "Profile",
    rive: RiveModel(
        src: "assets/rive/riveicons.riv",
        artboard: "USER",
        stateMachine: "USER_Interactivity"),
  )
];

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shake_event/shake_event.dart';
import 'package:sensors/sensors.dart'; // Use only one sensor package

class LoadingScreenInteractive extends StatefulWidget {
  @override
  _LoadingScreenInteractiveState createState() =>
      _LoadingScreenInteractiveState();
}

class _LoadingScreenInteractiveState extends State<LoadingScreenInteractive> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Lottie.asset('assets/lottie/data-fetching.json'),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DummyContainer extends StatelessWidget {
  const DummyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0), // Adjust as desired
              ),
              elevation: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    color: Colors.red,
                  ),
                  // child: !cameraController!.value.isInitialized
                  //     ? Container()
                  //     : AspectRatio(
                  //   aspectRatio: cameraController!.value.aspectRatio,
                  //   child: CameraPreview(cameraController!),
                  // ),
                ),
              ),
            ),
            Positioned(child: Image.asset('images/cornerTopRight.png',width: 70,), top: 20, right: 20),
            Positioned(child: Image.asset('images/cornerBottomLeft.png',width: 70,), bottom: 20, left: 20),
            Positioned(child: Image.asset('images/cornerBottomRight.png',width: 70,), bottom: 20, right: 20),
            Positioned(child: Image.asset('images/cornerTopLeft.png',width: 70,), top: 20, left: 20),
          ],
        ),
      ),
    );
  }
}

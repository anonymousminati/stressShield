import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'detectorHome.dart';


class FaceDetectionLandingPage extends StatelessWidget {
  const FaceDetectionLandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Live Emotion Detection App 🐇'),
          backgroundColor: const Color(0xfffe9400),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 5.0),
                child: SafeArea(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [


                        Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Stack(
                                  children: <Widget>[
                                    Positioned.fill(
                                      child: Container(

                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: <Color>[
                                              Color(0xFF0D47A1),
                                              Color(0xFF1976D2),
                                              Color(0xFF42A5F5),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.all(16.0),
                                        textStyle: const TextStyle(fontSize: 20),
                                        fixedSize: Size.fromHeight(150),
                                      ),
                                      onPressed: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(builder: (context) => const DetectorHome()),
                                        // );
                                      },
                                      child: const Text('Live From Camera'),
                                    ),
                                  ],
                                ),
                              ),
                            ]
                        ),
                        const SizedBox(height: 15.0),


                      ]
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
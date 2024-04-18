// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_tflite/flutter_tflite.dart';
// import 'package:stress_sheild/main.dart';
//
// class DetectorHome extends StatefulWidget {
//   const DetectorHome({Key? key}) : super(key: key);
//
//   @override
//   _DetectorHomeState createState() => _DetectorHomeState();
// }
//
// class _DetectorHomeState extends State<DetectorHome> {
//   CameraImage? cameraImage;
//   CameraController? cameraController;
//   String output = '';
//
//   @override
//   void initState() {
//     super.initState();
//     loadCamera();
//     loadmodel();
//   }
//
//   //create dispose method
//   @override
//   void dispose() {
//     super.dispose();
//     cameraController!.dispose();
//     // Tflite.close();
//   }
//
//   loadCamera() {
//     cameraController = CameraController(cameras![1], ResolutionPreset.high);
//     cameraController!.initialize().then((value) {
//       if (!mounted) {
//         return;
//       } else {
//         setState(() {
//           cameraController!.startImageStream((imageStream) {
//             cameraImage = imageStream;
//             runModel();
//           });
//         });
//       }
//     });
//   }
//
//   runModel() async {
//     if (cameraImage != null) {
//       var predictions = await Tflite.runModelOnFrame(
//           bytesList: cameraImage!.planes.map((plane) {
//             return plane.bytes;
//           }).toList(),
//           imageHeight: cameraImage!.height,
//           imageWidth: cameraImage!.width,
//           imageMean: 127.5,
//           imageStd: 127.5,
//           rotation: 90,
//           numResults: 2,
//           threshold: 0.1,
//           asynch: true);
//       predictions!.forEach((element) {
//         setState(() {
//           output = element['label'];
//         });
//       });
//     }
//   }
//
//   loadmodel() async {
//     await Tflite.loadModel(
//         model: "assets/model.tflite", labels: "assets/labels.txt");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: SafeArea(
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             Column(children: [
//               //create a row with title and and back button
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
//                 child: Row(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.black), // Add border color
//                       ),
//                       child: IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: Icon(Icons.arrow_back),
//                         color: Colors.black, // Set the color of the icon
//                       ),
//                     ),
//                     SizedBox(width: 10), // Add some spacing between the button and text
//                     Text(
//                       'Mood Detector',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black, // Set the color of the text
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//
//
//
//               Padding(
//                 padding: EdgeInsets.all(20),
//                 // child: Container(
//                 //   height: MediaQuery.of(context).size.height * 0.7,
//                 //   width: MediaQuery.of(context).size.width,
//                 //   child: !cameraController!.value.isInitialized
//                 //       ? Container()
//                 //       : AspectRatio(
//                 //     aspectRatio: cameraController!.value.aspectRatio,
//                 //     child: CameraPreview(cameraController!),
//                 //   ),
//                 // ),
//                 child: Stack(
//                   children: [
//                     Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30.0), // Adjust as desired
//                       ),
//                       elevation: 10,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(30.0),
//                         child: Container(
//                           height: MediaQuery.of(context).size.height * 0.7,
//                           width: MediaQuery.of(context).size.width,
//                           // child: Container(
//                           //   color: Colors.red,
//                           // ),
//                           child: !cameraController!.value.isInitialized
//                               ? Container()
//                               : AspectRatio(
//                             aspectRatio: cameraController!.value.aspectRatio,
//                             child: CameraPreview(cameraController!),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(child: Image.asset('images/cornerTopRight.png',width: 70,), top: 20, right: 20),
//                     Positioned(child: Image.asset('images/cornerBottomLeft.png',width: 70,), bottom: 20, left: 20),
//                     Positioned(child: Image.asset('images/cornerBottomRight.png',width: 70,), bottom: 20, right: 20),
//                     Positioned(child: Image.asset('images/cornerTopLeft.png',width: 70,), top: 20, left: 20),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Color(0xfffe9400),
//
//                   borderRadius: BorderRadius.all(Radius.circular(30)),
//                 ),
//                 child: Text(
//                   output,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 24,
//                     color: Colors.white,
//                     // Adjust based on background color
//                     height: 1.2,
//                     // Adjust line height for spacing
//                     fontFamily: 'OpenSans',
//                     // Example font (or a similar one)
//                   ),
//                 ),
//               )
//             ]),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:stress_sheild/feature/aiTherapyChatbot/screen/resultScreen.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/services/firebase_auth_service.dart';

import '../../../main.dart';
UserInformation userInformation = Get.put(UserInformation());
class DummyContainer extends StatefulWidget {
  const DummyContainer({Key? key}) : super(key: key);

  @override
  _DummyContainerState createState() => _DummyContainerState();
}

class _DummyContainerState extends State<DummyContainer> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';
  bool isLabelStable = false;
  bool isCameraInitialized = false;
  Timer? _debounce;
  bool isModelBusy = false;

  void runModelDebounced() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(milliseconds: 500), runModel);
  }

  @override
  void initState() {
    super.initState();
    loadCamera();
    loadmodel();
  }

  @override
  void dispose() {
    super.dispose();
    cameraController?.stopImageStream();
    cameraController?.dispose();
    Tflite.close();
  }

  loadCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      // Handle scenario where no cameras are available
      return;
    }
    cameraController = CameraController(cameras[1], ResolutionPreset.high);
    try {
      await cameraController!.initialize();
      setState(() {
        isCameraInitialized = true;
        cameraController!.startImageStream((imageStream) {
          cameraImage = imageStream;
          runModel();
        });
      });
    } catch (e) {
      // Handle camera initialization error
      print('Error initializing camera: $e');
    }
  }

  void runModel() async {
    if (!isModelBusy && cameraImage != null) {
      isModelBusy = true; // Set the flag to indicate that the model is busy
      try {
        var predictions = await Tflite.runModelOnFrame(
          bytesList: cameraImage!.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 2,
          threshold: 0.1,
          asynch: true,
        );
        if (predictions != null) {
          setState(() {
            output = predictions[0]['label'];
            if (!isLabelStable && output.isNotEmpty) {
              isLabelStable = true;
            }
          });
        }
      } catch (e) {
        print("Error running model: $e");
      } finally {
        isModelBusy = false; // Reset the flag when the model inference is completed
      }
    }
  }

  loadmodel() async {
    try {
      await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt",
      );
    } catch (e) {
      // Handle model loading error
      print('Error loading model: $e');
    }
  }

  void proceedToNextScreen() {
    if (isLabelStable) {
      final String currentOutput = output;
      // Stop camera stream and model inference
      cameraController?.stopImageStream();
      isModelBusy = false;

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Detected Mood is:'),
            content: Text(currentOutput),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  userInformation.mood_label.value = currentOutput.toString();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetectorHome(
                        detectedLabel: currentOutput,
                      ),
                    ),
                  ).then((_) {
                    // Restart camera stream and model inference
                    loadCamera();
                    loadmodel();
                    setState(() {
                      isLabelStable = false;
                    });
                  });
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
         Container(
           color: Color(0xFFEC7D1C),
         ),
          SafeArea(
            child: isCameraInitialized
                ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10.0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Mood Recognition',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Stack(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Container(
                            height:
                            MediaQuery.of(context).size.height * 0.7,
                            width: MediaQuery.of(context).size.width,
                            child: !cameraController!.value.isInitialized
                                ? Container()
                                : AspectRatio(
                              aspectRatio: cameraController!
                                  .value.aspectRatio,
                              child: CameraPreview(
                                  cameraController!),
                            ),
                          ),
                        ),
                      ),
                            Positioned(
                                child: Image.asset(
                                  'images/cornerTopRight.png',
                                  width: 70,
                                ),
                                top: 20,
                                right: 20),
                            Positioned(
                                child: Image.asset(
                                  'images/cornerBottomLeft.png',
                                  width: 70,
                                ),
                                bottom: 20,
                                left: 20),
                            Positioned(
                                child: Image.asset(
                                  'images/cornerBottomRight.png',
                                  width: 70,
                                ),
                                bottom: 20,
                                right: 20),
                            Positioned(
                                child: Image.asset(
                                  'images/cornerTopLeft.png',
                                  width: 70,
                                ),
                                top: 20,
                                left: 20),
                          ],
                  ),
                ),
                if (isLabelStable)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 43, 107, 255),
                          Color.fromARGB(255, 133, 57, 255)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: ElevatedButton(
                      onPressed: proceedToNextScreen,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, // Transparent background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 24.0,
                        ),
                        child: Text(
                          'Proceed',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            )
                : Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
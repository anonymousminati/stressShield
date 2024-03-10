import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:stress_sheild/main.dart';

class DetectorHome extends StatefulWidget {
  const DetectorHome({Key? key}) : super(key: key);

  @override
  _DetectorHomeState createState() => _DetectorHomeState();
}

class _DetectorHomeState extends State<DetectorHome> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';

  @override
  void initState() {
    super.initState();
    loadCamera();
    loadmodel();
  }

  //create dispose method
  @override
  void dispose() {
    super.dispose();
    cameraController!.dispose();
    // Tflite.close();
  }

  loadCamera() {
    cameraController = CameraController(cameras![1], ResolutionPreset.high);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((imageStream) {
            cameraImage = imageStream;
            runModel();
          });
        });
      }
    });
  }

  runModel() async {
    if (cameraImage != null) {
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
          asynch: true);
      predictions!.forEach((element) {
        setState(() {
          output = element['label'];
        });
      });
    }
  }

  loadmodel() async {
    await Tflite.loadModel(
        model: "assets/model.tflite", labels: "assets/labels.txt");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(children: [
              //create a row with title and and back button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black), // Add border color
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                        color: Colors.black, // Set the color of the icon
                      ),
                    ),
                    SizedBox(width: 10), // Add some spacing between the button and text
                    Text(
                      'Mood Detector',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Set the color of the text
                      ),
                    ),
                  ],
                ),
              ),




              Padding(
                padding: EdgeInsets.all(20),
                // child: Container(
                //   height: MediaQuery.of(context).size.height * 0.7,
                //   width: MediaQuery.of(context).size.width,
                //   child: !cameraController!.value.isInitialized
                //       ? Container()
                //       : AspectRatio(
                //     aspectRatio: cameraController!.value.aspectRatio,
                //     child: CameraPreview(cameraController!),
                //   ),
                // ),
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
                          // child: Container(
                          //   color: Colors.red,
                          // ),
                          child: !cameraController!.value.isInitialized
                              ? Container()
                              : AspectRatio(
                            aspectRatio: cameraController!.value.aspectRatio,
                            child: CameraPreview(cameraController!),
                          ),
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
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xfffe9400),

                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Text(
                  output,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                    // Adjust based on background color
                    height: 1.2,
                    // Adjust line height for spacing
                    fontFamily: 'OpenSans',
                    // Example font (or a similar one)
                  ),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}

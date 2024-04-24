import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stress_sheild/feature/mindful_resources/screens/playcourse.dart';
import 'package:stress_sheild/feature/smart_notification/screens/notification_landingPage.dart';
import 'package:stress_sheild/feature/smart_notification/screens/notification_page.dart';
import 'package:stress_sheild/global_widgets/audio/audioplayer%20widget.dart';
import 'package:stress_sheild/global_widgets/courseContentListWidget.dart';
import 'package:stress_sheild/global_widgets/service/firebaseStorageService.dart';
import 'package:stress_sheild/global_widgets/songListWidget.dart';
import 'package:stress_sheild/model/dataModels.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class Course extends StatefulWidget {
  final Map<String, dynamic> data;

  Course({Key? key, required this.data}) : super(key: key);

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  late Stream<DocumentSnapshot> snapshotStream;

  List<Map<String, dynamic>> musicList = [];

  String currentTitle = '';

  String currentImageUrl = '';

  String currentAudioUrl = '';

  bool isPlaing = false;

  AudioPlayer audioPlayer = AudioPlayer();

  int currentIndex = 0;

  PlayerState audioPlayerState = PlayerState.stopped;

  final firebaseStorageService = FirebaseStorageService();
  @override
  void initState() {
    super.initState();
    // _fetchSongsData();

    audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          audioPlayerState = state!;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  // Future<void> _fetchSongsData() async {
  //   try {
  //     audioPlayer.stop();
  //     currentIndex=0;
  //     setState(() {
  //       musicList = [];
  //     });
  //
  //     // musicList = List<Map<String, dynamic>>.from(widget.data['course_content'] as List<dynamic>);
  //     currentImageUrl =widget.data['img_url'] ?? '';
  //
  //     // // snapshotStream = widget.data['course_content'].snapshots();
  //     // snapshotStream = FirebaseFirestore.instance.collection('courses').doc().snapshots();
  //     // snapshotStream.listen((snapshot) {
  //     //   if (snapshot.exists) {
  //     //     setState(() {
  //     //       musicList = List<Map<String, dynamic>>.from(snapshot['course_content'] as List<dynamic>);
  //     //       currentImageUrl = widget.data['img_url'] ?? '';
  //     //       musicList.forEach((element) {
  //     //         element['img_url'] = currentImageUrl;
  //     //     });
  //     //
  //     //     });
  //     //
  //     //     // playAudio(
  //     //     //   musicList[currentIndex]['song_url'].toString(),
  //     //     //   musicList[currentIndex]['name'].toString(),
  //     //     //   musicList[currentIndex]['image_url'].toString(),
  //     //     // );
  //     //   }
  //     // });
  //   } catch (e) {
  //     print('Error fetching songs data: $e');
  //     setState(() {
  //       musicList = [];
  //     });
  //   }
  // }

  Future<void> playAudio(String url, String title, String imageUrl) async {
    try {
      if (currentAudioUrl == url) {
        if (audioPlayerState == PlayerState.playing) {
          await audioPlayer.pause();
        } else if (audioPlayerState == PlayerState.paused) {
          await audioPlayer.resume();
        }
      } else {
        await audioPlayer.stop();
        setState(() {
          currentTitle = title;
          currentImageUrl = imageUrl;
          currentAudioUrl = url;
        });

        print('this line printed0');

        final ref = FirebaseStorage.instance.refFromURL(url);
        print('this line printed1');

        final downloadUrl = await ref.getDownloadURL();
        print('this line printed2');

        final response = await http.get(Uri.parse(downloadUrl));
        print('this line printed3');

        final appDir = await getApplicationDocumentsDirectory();
        print('this line printed4');

        final audioPath = '${appDir.path}/audio.mp3';
        print('this line printed5');

        final audioFile = File(audioPath);
        print('this line printed6');

        await audioFile.writeAsBytes(response.bodyBytes);
        print('this line printed7');
        await audioPlayer.play(DeviceFileSource(audioPath));
        // await audioPlayer.setSourceBytes(audioFile as Uint8List ); // Use setUrl instead of setSource
        // await audioPlayer.play(url);
      }

      setState(() {
        currentTitle = title;
        currentImageUrl = imageUrl;
        currentAudioUrl = url;
      });
    } catch (e) {
      print('Error playing audio: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error playing audio. Please try again.'),
        ),
      );
      playAudio(url, title, imageUrl);
    }
  }

  // late  String audioUrl;
  Future<String> getAudioUrl(String filename) async {
    final url = await firebaseStorageService.getAudioUrl(filename);
    return url;
  }

  @override
  Widget build(BuildContext context) {
    // List<Widget> courseContainers = [];
    musicList = [];
    if (widget.data != null &&
        widget.data.isNotEmpty &&
        widget.data['course_content'] != null) {
      for (var course in widget.data['course_content']) {
        musicList.add({
          'name': course['audio_title'],
          'song_url': course['file_url'],
          'image_url': widget.data['img_url'],
        });

        // courseContainers.add(
        //   GestureDetector(
        //     onTap: () async {
        //       String url = await getAudioUrl(course['file_url']);
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => AudioPlayerWidget(audioUrl: url)),
        //       );
        //     },
        //     child: Container(
        //       padding: EdgeInsets.all(16),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //          Row(
        //            children: [
        //              Image.network(
        //                widget.data['img_url'] ?? '', // Add null check for 'image_url'
        //                width: 60,
        //                height: 60,
        //                fit: BoxFit.cover,
        //              ),
        //              SizedBox(width: 10),
        //              Text(
        //                course['audio_title'] ?? '', // Add null check for 'title'
        //                style: TextStyle(
        //                  fontSize: 22,
        //                  fontWeight: FontWeight.normal,
        //                ),
        //              ),
        //            ],
        //          ),
        //
        //
        //         ],
        //       ),
        //     ),
        //   ),
        // );
      }
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Color(0xFFE5E5E5),
              width: double.infinity,
              height: double.infinity,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFF4F3422),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              //create date and a notification icon and make them space between
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      size: 24.0,
                                      color: Colors.white,
                                    ),
                                    iconSize: 24.0,
                                    // Adjust the icon size as needed
                                    padding: EdgeInsets.zero,
                                    // Remove any default padding
                                    constraints: BoxConstraints(),
                                    // Remove any default constraints
                                    splashRadius:
                                        24.0, // Adjust the splash radius as needed
                                    // You can also add other properties like tooltip, alignment, etc. if needed
                                  ),
                                ),
                                Text(
                                  'Courses',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  width: 50.0,
                                  height: 50.0,
                                  padding: EdgeInsets.all(2.0),
                                  // Adjust padding as needed
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NotificationPage()),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.notifications,
                                      size: 24.0,
                                      color: Colors.white,
                                    ),
                                    splashRadius:
                                        24.0, // Adjust the splash radius as needed
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            //create a Row with Text "Article" and "Phylosophy"
                            SizedBox(
                              height: 50.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    // Adjust padding as needed
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white, // Border color
                                        width: 1, // Border width
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          25), // Border radius
                                    ),
                                    child: Text(
                                      "Course",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  // Add spacing between the two texts
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    // Adjust padding as needed
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white, // Border color
                                        width: 1, // Border width
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          25), // Border radius
                                    ),
                                    child: Text(
                                      "Freebie",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),

                            Text(
                              widget.data['course_title'],
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),

                            //create Row with star rating , views, comments. use logos for each add dot between them
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //create a Row with star rating , views, comments. use logos for each add dot between them
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.data['star'].toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.remove_red_eye_rounded,
                                  color: Colors.green[400],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.data['views'],
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.comment,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.data['comments'].toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            //create a container with text "By: John Doe" and a profile picture with background white. make follow button
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          "https://images.unsplash.com/photo-1515378791036-0648a3ef77b2?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.data['desc'],
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(30.0),
                  //       // Adjust the radius as needed
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey.withOpacity(0.5),
                  //           // Add a shadow for depth
                  //           spreadRadius: 2,
                  //           blurRadius: 4,
                  //           offset: Offset(0, 3), // changes position of shadow
                  //         ),
                  //       ],
                  //     ),
                  //     child: ListTile(
                  //       contentPadding: EdgeInsets.symmetric(
                  //           horizontal: 20.0, vertical: 10.0),
                  //       leading: Icon(
                  //         Icons.download,
                  //         size: 40.0,
                  //         color: Colors.brown,
                  //       ),
                  //       title: Text(
                  //         "Offline Download",
                  //         style: TextStyle(
                  //           fontSize: 20.0,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.brown,
                  //         ),
                  //       ),
                  //       subtitle: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           SizedBox(height: 5.0),
                  //           // Add some space between title and subtitle
                  //           Text(
                  //             "1.2 GB",
                  //             style: TextStyle(
                  //               fontSize: 16.0,
                  //               fontWeight: FontWeight.w600,
                  //               color: Colors.brown,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  //make a for loop and create a container with heading and description. check how many center are there in the list and create that many containers
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          musicList.length.toString() + " Audios",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        //create "view all" button
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.more_vert,
                            size: 40.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // GestureDetector(
                  //   onTap: () async {
                  //    String url=await getAudioUrl(widget.course['course'][0]['fileName']);
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => AudioPlayerWidget(audioUrl: url,)));
                  //
                  //     // Navigator.push(
                  //     //   context,
                  //     //   MaterialPageRoute(builder: (context) => PlayCourse()),
                  //     // );
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(16.0),
                  //     child: Container(
                  //
                  //       decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(30.0),
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Colors.grey.withOpacity(0.5),
                  //             spreadRadius: 2,
                  //             blurRadius: 4,
                  //             offset: Offset(0, 3),
                  //           ),
                  //         ],
                  //       ),
                  //       child: ListTile(
                  //         contentPadding: EdgeInsets.symmetric(
                  //             horizontal: 20.0, vertical: 10.0),
                  //         leading: Icon(
                  //           Icons.play_circle_fill,
                  //           size: 40.0,
                  //           color: Colors.green,
                  //         ),
                  //         title: Text(
                  //           widget.course['course'][0]['audioTitle'],
                  //           style: TextStyle(
                  //             fontSize: 20.0,
                  //             fontWeight: FontWeight.bold,
                  //             color: Colors.black,
                  //           ),
                  //         ),
                  //         subtitle: Text(
                  //           "⭐ 4.5",
                  //           style: TextStyle(
                  //             fontSize: 16.0,
                  //             fontWeight: FontWeight.w600,
                  //             color: Colors.grey,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )

                  Container(
                    height: 400,
                    child: CourseAudioListWidget(
                        musicList: musicList, playAudio: playAudio),
                  ),

                  // ListView(
                  //    shrinkWrap: true,
                  //    physics: NeverScrollableScrollPhysics(),
                  //    children: courseContainers,
                  //  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

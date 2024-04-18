import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/customnavbar.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/landing_home_page.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/services/firebase_auth_service.dart';
import 'package:stress_sheild/feature/smart_notification/screens/notification_landingPage.dart';
import 'package:stress_sheild/global_widgets/audioPlayertest.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
final UserInformation _userInformation = Get.put(UserInformation());

class PlayCourse extends StatefulWidget {
  const PlayCourse(
      {super.key,
      required this.audioUrl,
      required this.audioTitle,
      required this.imageUrl});

  final String audioTitle;
  final String imageUrl;
  final String audioUrl;

  // final Function(String, String, String) playAudio;

  @override
  State<PlayCourse> createState() => _PlayCourseState();
}

class _PlayCourseState extends State<PlayCourse> {
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;

  String currentTitle = '';

  String currentImageUrl = '';

  String currentAudioUrl = '';

  bool isPlaing = false;

  late AudioPlayer audioPlayer;
  PlayerState audioPlayerState = PlayerState.stopped;

  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer = AudioPlayer();

    _initializeAudioPlayer();
    playAudio(
      widget.audioUrl,
      widget.audioTitle,
      widget.imageUrl,
    );

    audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          audioPlayerState = state!;
        });
      }
    });


    audioPlayer.onPositionChanged.listen((Duration duration) {
      if (mounted) {
        setState(() {
          currentPosition = duration;
        });
      }
    });

    audioPlayer.onDurationChanged.listen((Duration duration) {
      if (mounted) {
        setState(() {
          totalDuration = duration;
        });
      }
    });
  }

  Future<void> _initializeAudioPlayer() async {
    audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          audioPlayerState = state!;
        });
      }
    });
    audioPlayer.onPlayerComplete.listen((event) {

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return _popup();
          },
        );

    });
  }

  void _showCompletedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Audio Completed'),
        content: Text('The audio has been completed.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _seekForward() async {
    final Duration? currentPosition = await audioPlayer.getCurrentPosition();
    final Duration newPosition = currentPosition! + Duration(seconds: 25);
    await audioPlayer
        .seek(newPosition)
        .then((value) => print('Seeked to $newPosition '));
  }

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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.dispose();
  }
  Widget _popup(){

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Image.asset('images/popup (2).jpg'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Well Done!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4F3422),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'You have successfully completed the article. You have earned 5 points.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Color(0xFF4F3422),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: TextButton.icon(
                    onPressed: (){
                      var addScore = 5;
                      _userInformation.freud_score.value += addScore;
                      print('Freud Score: ${_userInformation.freud_score.value}');
                      _userInformation.audio_score.value +=addScore;
                      print('audio Score: ${_userInformation.audio_score}');
                      _userInformation.uploadUserInformation();
                      // Handle 'Mark as Read' button press
                      print('Mark as Read Pressed!');
                      _userInformation.fetchUserInformation();
                      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) =>BottomNavWithAnimations() ,) , (route) => false);

                    },
                    style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Great. Thanks!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        ],
      ),
    );

  }
  @override
  Widget build(BuildContext context) {

    final maxValue = totalDuration.inMilliseconds.ceil().toDouble();

    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Color(0xFF449855),
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
                      color: Colors.transparent,
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
                                  'Course',
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
                                                NotificationLandingPage()),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            width: 400,
                            height: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                              image: DecorationImage(
                                image: NetworkImage(widget.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            widget.audioTitle,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Slider(
                            min: 0.0,
                            max: maxValue,
                            value: currentPosition.inMilliseconds.toDouble(),
                            onChanged: (value) {
                              final Duration newPosition =
                              Duration(milliseconds: value.toInt());
                              audioPlayer.seek(newPosition);
                            },
                            activeColor: Colors.white,
                            inactiveColor: Colors.grey,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (audioPlayerState == PlayerState.playing) {
                                    audioPlayer.pause();
                                  } else if (audioPlayerState ==
                                      PlayerState.paused) {
                                    audioPlayer.resume();
                                  }
                                },
                                icon: Icon(
                                  audioPlayerState == PlayerState.playing
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 40.0,
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: audioPlayerState == PlayerState.completed ? null : _seekForward,
                                child: Text('Seek Forward 5s'),
                              ),
                            ],
                          ),

                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            // Adjust padding as needed
                            child: ElevatedButton(

                              onPressed:(){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _popup();
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Color(0xFF4F3422), // Text color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                padding: EdgeInsets.all(20),
                                // Adjust padding as needed
                              ),
                              child: Text(
                                'Mark as Complete',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

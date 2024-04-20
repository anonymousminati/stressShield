import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:stress_sheild/feature/home_and_mental_health_score/screens/customnavbar.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/landing_home_page.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/services/firebase_auth_service.dart';
import 'package:stress_sheild/global_widgets/exerciseCompletePopUp.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

final UserInformation _userInformation = Get.put(UserInformation());

class BreathExercise extends StatefulWidget {
  const BreathExercise(
      {Key? key,
      required this.selectedGoal,
      required this.selectedDuration,
      required this.audioUrl})
      : super(key: key);
  final String selectedGoal;
  final Duration selectedDuration;
  final String audioUrl;

  @override
  _BreathExerciseState createState() => _BreathExerciseState();
}

class _BreathExerciseState extends State<BreathExercise> {


  late Color _currentColor;
  final audioPlayer = AudioPlayer(); // Create a player
  PlayerState audioPlayerState = PlayerState.stopped;
  late Duration duration;
  late bool isPlaying = false;
  late String currentAudioUrl = '';

  @override
  void initState() {
    super.initState();
    _currentColor = Color(0xFF9BB167);
    // Start playing the audio automatically
    playAudio(widget.audioUrl);
    //create a 30sec timer after which it will redirect to next screen

  }

  dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Widget _popup() {
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
                    onPressed:(){


                      var addScore = 5;
                      _userInformation.freud_score.value += addScore;
                      print('Freud Score: ${_userInformation.freud_score.value}');
                      _userInformation.mindful_hours_score.value +=addScore;
                      print('mindful Score: ${_userInformation.mindful_hours_score}');
                      _userInformation.uploadUserInformation();
                      // Handle 'Mark as Read' button press
                      print('Mark as Read Pressed!');
                      _userInformation.fetchUserInformation();

                      Navigator.pushAndRemoveUntil(

                        context,
                        MaterialPageRoute(builder: (context) =>  BottomNavWithAnimations()),
                            (Route<dynamic> route) => false,
                      );
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

  Future<void> playAudio(
    String url,
  ) async {
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
        Future.delayed(Duration(seconds: 5), () {
          showDialog(
            context: context,
            builder: (context) {
              return _popup();
            },
          );
        });
        // await audioPlayer.setSourceBytes(audioFile as Uint8List ); // Use setUrl instead of setSource
        // await audioPlayer.play(url);
      }

      setState(() {
        currentAudioUrl = url;
      });
    } catch (e) {
      print('Error playing audio: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error playing audio. Please try again.'),
        ),
      );
      playAudio(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            TweenAnimationBuilder(
              tween: ColorTween(begin: _currentColor, end: Color(0xFFED7E1C)),
              duration: Duration(seconds: 1),
              builder: (context, Color? color, child) {
                if (color != null) {
                  _currentColor = color;
                }
                return Container(
                  width: 200,
                  height: 200,
                  color: _currentColor,
                  child: Center(
                    child: Text(
                      'Color Tween',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 2, color: Colors.white),
                  ),
                  child: ListTile(
                    leading: Container(
                      child: IconButton(
                        icon: const Icon(Icons.audiotrack_sharp),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    title: Text(
                      'Sound Chirping Birds',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Lottie.asset(
                    'assets/lottie/breathing.json',
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
                Container(
                  width: 60, // Set width to accommodate the larger icon
                  height: 60, // Set height to accommodate the larger icon
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // Make it circular
                    color: Colors.white, // Set background color to white
                  ),
                  child: IconButton(
                    iconSize: 40, // Set icon size to be larger
                    icon: Icon(
                      audioPlayerState == PlayerState.playing
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Color(0xFFED7E1C), // Set icon color
                    ),
                    onPressed: () {
                      if (audioPlayerState == PlayerState.playing) {
                        audioPlayer.pause();
                        setState(() {
                          audioPlayerState = PlayerState.paused;
                        });
                      } else {
                        audioPlayer.resume();
                        setState(() {
                          audioPlayerState = PlayerState.playing;
                        });
                      }
                    },
                  ),
                ),
SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Color(0xFF4F3422),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return _popup();
                        },
                      );
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
                      'Mark as Complete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

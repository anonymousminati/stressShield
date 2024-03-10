import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:just_audio/just_audio.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/landing_home_page.dart';
import 'package:stress_sheild/global_widgets/exerciseCompletePopUp.dart';

class BreathExercise extends StatefulWidget {
  const BreathExercise({Key? key}) : super(key: key);

  @override
  _BreathExerciseState createState() => _BreathExerciseState();
}

class _BreathExerciseState extends State<BreathExercise> {
  final ShowDialogPopup _popup = ShowDialogPopup();

  late Color _currentColor;
  final player = AudioPlayer(); // Create a player
  late Duration duration;
  late bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _currentColor = Color(0xFF9BB167);
    _initPlayer();
    _playAudio();// Start playing the audio automatically

    //create a 30sec timer after which it will redirect to next screen
    Future.delayed(Duration(seconds: 30), () {
      _pauseAudio();
      _popup.showImageAlertDialog(
        context,
        'images/popup.jpg',
        'AI Suggestions Completed.+5 Freud Score Added',
        'Your Freud score is increased to 88!',
          (){
            Navigator.push(

              context,
              MaterialPageRoute(builder: (context) =>  LandingHomePage()),
            );
          }
      );



    });

  }
  dispose() {
    player.dispose();
    super.dispose();
  }

  _initPlayer() async {
    await player.setAsset('assets/audio/breathing.mp3');
    player.positionStream.listen((position) {
      // Update the position (if needed)
    });
    player.durationStream.listen((duration) {
      setState(() {
        this.duration = duration!;
      });
    });
  }

  _playAudio() async {
    await player.play();
    setState(() {
      isPlaying = true;
    });
  }

  _pauseAudio() async {
    await player.pause();
    setState(() {
      isPlaying = false;
    });
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
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Play/pause toggle button
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
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Color(0xFFED7E1C), // Set icon color
                          ),
                          onPressed: () {
                            if (isPlaying) {
                              _pauseAudio();
                            } else {
                              _playAudio();
                            }
                          },
                        ),
                      ),

                      // Forward button
                      IconButton(
                        iconSize: 40,
                        icon: Icon(Icons.forward_5_outlined ,color: Colors.white,),
                        onPressed: () {

                          player.seek(player.position + Duration(seconds: 5));
                        },
                      ),
                    ],
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

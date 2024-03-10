import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:lottie/lottie.dart';
import 'package:stress_sheild/feature/mindful_resources/screens/courseComplete.dart';
import 'package:stress_sheild/feature/smart_notification/screens/notification_landingPage.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;

  const AudioPlayerWidget({Key? key, required this.audioUrl}) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  // State management (replace with your provider implementation)
  // final AudioPlayerState audioPlayerState; // Example

  @override
  void initState() {
    super.initState();
    setupAudioPlayer();
    togglePlay(); // Automatically start playing the audio
  }


  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Handle audio player state updates (replace with provider logic)
  // void updateAudioPlayerState(bool isPlaying, Duration position, Duration duration) {
  //   audioPlayerState.updateState(isPlaying, position, duration);
  // }

  void setupAudioPlayer() async {
    await _audioPlayer.setSource(UrlSource(widget.audioUrl));
    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
    _audioPlayer.onPlayerComplete.listen((event) {
      complete();
     // Call the complete function when audio completes
    });
  }

  void complete() {
    print('Current audio complete');
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => CourseComplete())
    );// Navigate back to the previous page
  }


  void togglePlay() async {
    try {
      if (isPlaying) {
        await _audioPlayer.pause();
        setState(() {
          isPlaying = false;
        });
      } else {
        await _audioPlayer.resume();
        setState(() {
          isPlaying = true;
        });
      }
    } catch (e) {
      print('Error playing audio: $e');
      // Handle playback error (e.g., show a snackbar to the user)
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
          fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
             color: Color(0xff538634),


            ),
          ),
          Scaffold(
backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(0.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                // Create date and a notification icon and make them space between
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0), // Half of the width/height to make it circular
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
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
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      splashRadius: 24.0,
                    ),
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0), // Half of the width/height to make it circular
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
                            builder: (context) => NotificationLandingPage(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.notifications,
                        size: 24.0,
                        color: Colors.white,
                      ),
                      splashRadius: 24.0,
                    ),
                  ),
                ],
              ),

            ),
          ),

          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              //create a container which plays lottie file
              Container(
                child: Lottie.asset(
                  'assets/lottie/AudioWaves.json',
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
              Slider(

                value: position.inSeconds.toDouble(),
                min: 0.0,
                max: duration.inSeconds.toDouble(),
                onChanged: (value) async {
                  await _audioPlayer.seek(Duration(seconds: value.toInt()));
                },
                activeColor: Colors.white, // Customize the active color of the slider
                inactiveColor: Colors.grey, // Customize the inactive color of the slider
              ),
              SizedBox(
                height: 20.0,
              ),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Color(0xff538634), // Customize the icon color
                    size: 50.0, // Adjust the icon size
                  ),
                  onPressed: togglePlay,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                '${position.toString().split('.').first}/${duration.toString().split('.').first}',
                style: TextStyle(
                  fontSize: 18.0, // Adjust the font size
                  color: Colors.white, // Customize the text color
                  fontWeight: FontWeight.bold, // Add font weight
                ),
              ),
            ],
          ),
        )],
      ),
    );
  }
}
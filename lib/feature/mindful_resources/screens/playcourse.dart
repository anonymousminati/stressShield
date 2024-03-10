import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:stress_sheild/feature/smart_notification/screens/notification_landingPage.dart';
import 'package:stress_sheild/global_widgets/audioPlayertest.dart';

class PlayCourse extends StatelessWidget {
  const PlayCourse({super.key});

  @override
  Widget build(BuildContext context) {
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
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Mindfullness Meditation Intro",
                            textAlign: TextAlign.center,
                            style: TextStyle(

                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      //   create a circular progress indecater  to show  the progress of audio
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.blue, // Border color
                          width: 2.0, // Border width
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: CircularProgressIndicator(
                        value: 0.5, // Set the value to indicate the progress (0.0 to 1.0)
                        strokeWidth: 8.0, // Adjust the thickness of the progress indicator
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Set the color of the progress indicator
                        backgroundColor: Colors.grey[300], // Set the background color of the progress indicator
                        semanticsLabel: 'Audio Progress', // Optional label for accessibility
                      ),
                    ),
                        // CourseAudioPlayer(audioUrl: 'http://traffic.libsyn.com/mindfulorg/12MM_-_Part_III__A_Meditation_to_Replenish_Cognitive_Energy__-_Shalini_Bahl-Milne_-_Jan._19_2024.mp3',),
                        AudioPlayerTest(),
                    ],
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



class CourseAudioPlayer extends StatefulWidget {
  final String audioUrl;

  const CourseAudioPlayer({super.key, required this.audioUrl}); // Add a field to store the network audio URL

  @override
  _CourseAudioPlayerState createState() => _CourseAudioPlayerState();
}

class _CourseAudioPlayerState extends State<CourseAudioPlayer> {
  final _audioPlayer = AudioPlayer();
  double _playbackProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _playbackProgress = position.inSeconds / _audioPlayer.duration!.inSeconds;
      });
    });
    _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(widget.audioUrl))); // Set the network audio source
  }
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPause() {
    if (_audioPlayer.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  void _playNext() {
    // Replace this with your logic to play the next audio source
    print('Playing next audio');
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          value: _playbackProgress,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(_audioPlayer.playing ? Icons.pause : Icons.play_arrow),
              onPressed: _playPause,
            ),
            IconButton(
              icon: Icon(Icons.skip_next),
              onPressed: _playNext,
            ),
          ],
        ),
      ],
    );
  }
}
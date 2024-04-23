import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/customnavbar.dart';
import 'package:stress_sheild/feature/smart_notification/screens/notification_landingPage.dart';
import 'package:stress_sheild/feature/smart_notification/screens/notification_page.dart';
import 'package:stress_sheild/global_widgets/songListWidget.dart';

class MusicPlay extends StatefulWidget {
  const MusicPlay({Key? key}) : super(key: key);

  @override
  State<MusicPlay> createState() => _MusicPlayState();
}

class _MusicPlayState extends State<MusicPlay> {
  final List<Map<String, dynamic>> emotions = [
    {'emotion': 'happy', 'icon': Icons.sentiment_satisfied},
    {'emotion': 'sad', 'icon': Icons.sentiment_dissatisfied},
    {'emotion': 'angry', 'icon': Icons.sentiment_very_dissatisfied},
    // {'emotion': 'neutral', 'icon': Icons.sentiment_neutral},
    {'emotion': 'surprise', 'icon': Icons.sentiment_satisfied_alt},
    // {'emotion': 'disgust', 'icon': Icons.sentiment_very_dissatisfied},
    {'emotion': 'fear', 'icon': Icons.sentiment_very_dissatisfied},
  ];
  late Stream<DocumentSnapshot> snapshotStream;
  List<Map<String, dynamic>> musicList = [];
  String currentTitle = '';
  String currentImageUrl = '';
  String currentAudioUrl = '';
  bool isPlaing = false;
  AudioPlayer audioPlayer = AudioPlayer();
  int currentIndex = 0;
  PlayerState audioPlayerState = PlayerState.stopped;
  Duration duration = Duration();
  Duration position = Duration();
  late String detectedLabel = 'happy';

  @override
  void initState() {
    super.initState();
    _fetchSongsData();

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

  Future<void> _fetchSongsData() async {
    try {
      audioPlayer.stop();
      currentIndex = 0;
      setState(() {
        musicList = [];
      });
      snapshotStream = FirebaseFirestore.instance
          .collection('Music')
          .doc(detectedLabel)
          .snapshots();

      snapshotStream.listen((snapshot) {
        if (snapshot.exists) {
          setState(() {
            musicList = List<Map<String, dynamic>>.from(snapshot.get('musics'));
          });

          playAudio(
            musicList[currentIndex]['song_url'].toString(),
            musicList[currentIndex]['name'].toString(),
            musicList[currentIndex]['image_url'].toString(),
          );
        }
      });
    } catch (e) {
      print('Error fetching songs data: $e');
      setState(() {
        musicList = [];
      });
    }
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

      audioPlayer.onDurationChanged.listen((event) {
        print('duration:$event');
        setState(() {
          duration = event ?? Duration.zero;
        });
      });

      audioPlayer.onPositionChanged.listen((event) {
        setState(() {
          position = event ?? Duration.zero;
        });
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          _fetchSongsData();
        },
        child: Scaffold(
          backgroundColor: Color(0xFF2A5360),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavWithAnimations(),
                            ),
                            (route) => false);
                      },
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                    ),
                    Text(
                      'Audio Therapy',
                      style: TextStyle(
                        color: Color(0xFF50E4FF),
                        fontSize: 25,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationPage()));
                      },
                      icon: Icon(Icons.notifications),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                child: ListView.builder(
                  itemCount: emotions.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final emotion = emotions[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            detectedLabel = emotion['emotion'];
                          });
                          audioPlayer.stop();
                          _fetchSongsData();
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: detectedLabel ==
                                        emotion['emotion'].toLowerCase()
                                    ? Color(0xFF50E4FF)
                                    : Colors.transparent,
                                border: Border.all(
                                  color: Color(0xFFFFFFFF),
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                emotion['icon'],
                                color: detectedLabel ==
                                        emotion['emotion'].toLowerCase()
                                    ? Colors.white
                                    : Color(0xFF50E4FF),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              emotion['emotion'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                  child: AudioListWidget(
                musicList: musicList,
                playAudio: playAudio,
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: currentImageUrl.isNotEmpty
                                ? NetworkImage(currentImageUrl)
                                : AssetImage('images/dummyImage.jpg')
                                    as ImageProvider,
                          ),
                          Text(
                            currentTitle,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (currentIndex > 0) {
                                setState(() {
                                  currentIndex--; // Move to the previous song in the list
                                });
                                playAudio(
                                  musicList[currentIndex]['song_url']
                                      .toString(),
                                  musicList[currentIndex]['name'].toString(),
                                  musicList[currentIndex]['image_url']
                                      .toString(),
                                );
                              }
                            },
                            icon:
                                Icon(Icons.skip_previous, color: Colors.white),
                          ),
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
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (currentIndex < musicList.length - 1) {
                                setState(() {
                                  currentIndex++; // Move to the next song in the list
                                });
                                playAudio(
                                  musicList[currentIndex]['song_url']
                                      .toString(),
                                  musicList[currentIndex]['name'].toString(),
                                  musicList[currentIndex]['image_url']
                                      .toString(),
                                );
                              }
                            },
                            icon: Icon(Icons.skip_next, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

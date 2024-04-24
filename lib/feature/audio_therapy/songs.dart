import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stress_sheild/feature/audio_therapy/music_player.dart';

class SongRecommendationPage extends StatefulWidget {
  @override
  State<SongRecommendationPage> createState() => _SongRecommendationPageState();
}

class _SongRecommendationPageState extends State<SongRecommendationPage>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> emotions = [
    {'emotion': 'happy', 'icon': Icons.sentiment_satisfied},
    {'emotion': 'sad', 'icon': Icons.sentiment_dissatisfied},
    {'emotion': 'angry', 'icon': Icons.sentiment_very_dissatisfied},
    {'emotion': 'neutral', 'icon': Icons.sentiment_neutral},
    {'emotion': 'surprise', 'icon': Icons.sentiment_satisfied_alt},
    {'emotion': 'disgust', 'icon': Icons.sentiment_very_dissatisfied},
    {'emotion': 'fear', 'icon': Icons.sentiment_very_dissatisfied},
  ];
  late String detectedLabel = 'happy';
  List<dynamic>? songsData;
  bool isDownloadingAudio = false;
  late final AudioPlayer _audioPlayer;
  bool isPlaying = false;
  Map<String, dynamic>? currentSong;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _fetchSongsData();
  }

  Future<void> _fetchSongsData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Music')
          .doc(detectedLabel.toLowerCase())
          .get();

      if (snapshot.exists) {
        setState(() {
          songsData = snapshot.get('musics');
        });
      } else {
        setState(() {
          songsData = [];
        });
      }
    } catch (e) {
      print('Error fetching songs data: $e');
      setState(() {
        songsData = [];
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF2A5360),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildIconButton(Icons.arrow_back, () {
                      Navigator.pop(context);
                    }),
                    Text(
                      'Audio Therapy',
                      style: TextStyle(
                        color: Color(0xFF50E4FF),
                        fontSize: 25,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildIconButton(Icons.notifications, () {
                      // Navigate to notification page
                    }),
                  ],
                ),
              ),
              _buildEmotionListView(),
              SizedBox(height: 10),
              _buildSongList(),
              SizedBox(height: 20),
              if (currentSong != null) ...[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        currentSong!['name'].toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          if (isPlaying) {
                            _audioPlayer.pause();
                          } else {
                            _audioPlayer.play();
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _playNextSong();
                        },
                        icon: Icon(Icons.skip_next, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          _playPreviousSong();
                        },
                        icon: Icon(Icons.skip_previous, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Function() onPressed) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        color: Colors.white,
      ),
    );
  }

  Widget _buildEmotionListView() {
    return Container(
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
                _fetchSongsData();
              },
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: detectedLabel == emotion['emotion'].toLowerCase()
                          ? Color(0xFF50E4FF)
                          : Colors.transparent,
                      border: Border.all(
                        color: Color(0xFFFFFFFF),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      emotion['icon'],
                      color: detectedLabel == emotion['emotion'].toLowerCase()
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
    );
  }

  Widget _buildSongList() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Music')
            .doc(detectedLabel.toLowerCase())
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          return MusicPlay();
        },
      ),
    );
  }

  Future<void> _playNextSong() async {
    if (songsData != null && currentSong != null) {
      int currentIndex = songsData!.indexWhere((song) => song == currentSong);
      if (currentIndex != -1 && currentIndex < songsData!.length - 1) {
        Map<String, dynamic> nextSong = songsData![currentIndex + 1];
        _playSong(nextSong);
      }
    }
  }

  Future<void> _playPreviousSong() async {
    if (songsData != null && currentSong != null) {
      int currentIndex = songsData!.indexWhere((song) => song == currentSong);
      if (currentIndex != -1 && currentIndex > 0) {
        Map<String, dynamic> previousSong = songsData![currentIndex - 1];
        _playSong(previousSong);
      }
    }
  }

  Future<void> _playSong(Map<String, dynamic> song) async {
    setState(() {
      isDownloadingAudio = true;
    });

    try {
      final ref = FirebaseStorage.instance.refFromURL(song['song_url']);
      final downloadUrl = await ref.getDownloadURL();
      final response = await http.get(Uri.parse(downloadUrl));
      final appDir = await getApplicationDocumentsDirectory();
      final audioPath = '${appDir.path}/audio.mp3';
      final audioFile = File(audioPath);
      await audioFile.writeAsBytes(response.bodyBytes);
      await _audioPlayer.setFilePath(audioPath);
      await _audioPlayer.play();
      setState(() {
        isPlaying = true;
        currentSong = song;
        isDownloadingAudio = false;
      });
    } catch (e) {
      setState(() {
        isDownloadingAudio = false;
      });
      print('Error playing audio: $e');
    }
  }
}

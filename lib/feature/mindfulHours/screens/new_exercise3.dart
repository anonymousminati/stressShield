import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stress_sheild/feature/mindfulHours/screens/breathExercise.dart';
import 'package:wheel_picker/wheel_picker.dart';

List<String> buttonNames = [
  'Serene Journey',
  'Tranquil Oasis',
  'Peaceful Retreat',
  'Calm Reflection',
  'Mindful Moments',
  'Zen Harmony',
  'Inner Balance',
  'Quiet Mindfulness',
  'Blissful Silence',
  'Still Waters'
];

class NewExercise3 extends StatefulWidget {
  const NewExercise3(
      {super.key,
      required this.selectedGoal,
      required this.selectedDuration,
      required this.receivePort});
  final String selectedGoal;
  final Duration selectedDuration;
  final ReceivePort receivePort;
  @override
  State<NewExercise3> createState() => _NewExercise3State();
}

class _NewExercise3State extends State<NewExercise3> {
  int _selectedIndex = -1;
  Duration _duration = Duration(hours: 0, minutes: 0);
  final secondsWheel = WheelPickerController(itemCount: 59);
  final minutesWheel = WheelPickerController(itemCount: 59);
  static const textStyle =
      TextStyle(fontSize: 70, height: 1.5, color: Colors.white);
  String audio_url = '';
  List<Map<String, dynamic>> musics = [];

  @override
  void initState() {
    super.initState();
    fetchMusics();
  }

  Future<void> fetchMusics() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('exerciseaudio')
          .doc(widget.selectedGoal)
          .get();
      final musicsData = await querySnapshot.data()?['musics'];
      if (musicsData != null) {
        setState(() {
          musics = List<Map<String, dynamic>>.from(musicsData);
        });
      } else {
        setState(() {
          musics =
              []; // Initialize musics as an empty list if musicsData is null
        });
      }
    } catch (e) {
      setState(() {
        musics = []; // Initialize musics as an empty list in case of an error
      });
      print('Error fetching musics: $e');
      // Show a snackbar or dialog to inform the user about the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Error fetching musics. Please check your internet connection and try again.'),
          action: SnackBarAction(
            label: 'Retry',
            onPressed:
                fetchMusics, // Retry fetching musics when the user taps Retry
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return musics == null
        ? CircularProgressIndicator()
        : SafeArea(
            child: RefreshIndicator(
              onRefresh: fetchMusics,
              child: Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: FloatingActionButton.extended(
                  extendedPadding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.2),
                  label: Text('Continue',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.brown,
                  onPressed: _selectedIndex != -1
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BreathExercise(
                                      selectedGoal: widget.selectedGoal,
                                      selectedDuration: widget.selectedDuration,
                                      audioUrl: audio_url,
                                      receivePort: widget.receivePort,
                                    )),
                          );
                        }
                      : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  elevation: 4.0,
                  splashColor: Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  highlightElevation: 8.0,
                  focusElevation: 8.0,
                  hoverElevation: 8.0,
                ),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight + 32),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AppBar(
                      leading: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border:
                              Border.all(width: 2, color: Color(0xff0A0A0A)),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          color: Color(0xff4F3422),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'New Exercise',
                              style: TextStyle(
                                color: Color(0xff4F3422),
                                fontWeight: FontWeight.w800,
                                fontSize: 24,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffd68ade),
                              ),
                              child: Text(
                                '3 of 3',
                                style: TextStyle(
                                  color: Color(0xff4F3422),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Select Soundscapes",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff4F3422),
                          fontWeight: FontWeight.w800,
                          fontSize: 36,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //create a container which uses lottiefile which shous soundWaves.json
                                  Container(
                                    child: Lottie.asset(
                                      'assets/lottie/sound_wave.json',
                                      fit: BoxFit.fill,
                                      width: MediaQuery.of(context).size.width,
                                      height: 300,
                                    ),
                                  ),
                                  //create a horizontal slider with 7 button . on selection of a button at a single time only one button should be selected, the button should be highlighted with a border and the color of the button should be changed to orange
                                  SizedBox(height: 20),
                                  Container(
                                    height: 45,
                                    child: musics != null
                                        ? ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: musics.length,
                                            itemBuilder: (context, index) {
                                              print("musics: $musics");
                                              final music = musics[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  audio_url =
                                                      music['audio_url'];
                                                  setState(() {
                                                    _selectedIndex = index;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 8),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8),
                                                  decoration: BoxDecoration(
                                                    color: _selectedIndex ==
                                                            index
                                                        ? Color(0xFFED7E1C)
                                                        : Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    border: Border.all(
                                                      color: _selectedIndex ==
                                                              index
                                                          ? Color(0xFFF5A259)
                                                              .withOpacity(0.8)
                                                          : Color(0xFF4F3422),
                                                      width: _selectedIndex ==
                                                              index
                                                          ? 5
                                                          : 2,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    music['title'],
                                                    style: TextStyle(
                                                      color: _selectedIndex ==
                                                              index
                                                          ? Colors.white
                                                          : Color(0xFF4F3422),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : Center(
                                            child:
                                                CircularProgressIndicator()), // Show loading indicator while fetching musics
                                  ),

                                  SizedBox(height: 20),
                                  //create a search bar with hint text "Search Soundscapes" and a search icon
                                  // Container(
                                  //   width: MediaQuery.of(context).size.width *0.6,
                                  //   decoration: BoxDecoration(
                                  //     color: Colors.transparent,
                                  //     borderRadius: BorderRadius.circular(20),
                                  //   ),
                                  //   child: TextField(
                                  //     decoration: InputDecoration(
                                  //       hintText: 'Search Soundscapes',
                                  //       hintStyle: TextStyle(color: Color(0xFF4F3422)),
                                  //       prefixIcon: Icon(Icons.search, color: Color(0xFF4F3422)),
                                  //       border: OutlineInputBorder(
                                  //         borderSide: BorderSide.none,
                                  //         borderRadius: BorderRadius.circular(20),
                                  //       ),
                                  //       filled: true,
                                  //       fillColor: Colors.transparent,
                                  //       contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                                  //     ),
                                  //   ),
                                  // ),
                                  //
                                ],
                              ),
                            ),
                            //create a text "minutes" with color D2CECB and font size 24
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
          );
  }
}

class HorizontalSlider extends StatefulWidget {
  final List<String> buttonNames;

  HorizontalSlider({required this.buttonNames});

  @override
  _HorizontalSliderState createState() => _HorizontalSliderState();
}

class _HorizontalSliderState extends State<HorizontalSlider> {
  int _selectedIndex = -1;
  final ScrollController _controller = ScrollController();

  void _onButtonTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _controller,
      child: Row(
        children: List.generate(widget.buttonNames.length, (index) {
          return GestureDetector(
            onTap: () {
              _onButtonTapped(index);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _selectedIndex == index
                    ? Color(0xFFED7E1C)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: _selectedIndex == index
                      ? Color(0xFFF5A259).withOpacity(0.8)
                      : Color(0xFF4F3422),
                  width: _selectedIndex == index ? 5 : 2,
                ),
              ),
              child: Text(
                widget.buttonNames[index],
                style: TextStyle(
                  color: _selectedIndex == index
                      ? Colors.white
                      : Color(0xFF4F3422),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

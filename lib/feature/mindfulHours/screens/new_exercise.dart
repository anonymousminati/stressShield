import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stress_sheild/feature/mindfulHours/screens/new_exercise2.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/services/firebase_auth_service.dart';

void startMindfullTimer(SendPort sendPort) {
  int counter = 0;
  Timer.periodic(Duration(seconds: 1), (Timer t) {
    counter++;
    sendPort.send(counter);
  });
}

class NewExercise extends StatefulWidget {
  const NewExercise({Key? key}) : super(key: key);

  @override
  _NewExerciseState createState() => _NewExerciseState();
}

class _NewExerciseState extends State<NewExercise> {
  int _selectedIndex = -1; // Initially no card is selected

  List<String> exerciseGoals = [
    "Exercise to stay physically fit",

    "I want a nap",

    "I want to improve myself",

    "I want to meditate",

    "I want to stay calm",

    "I want to stay happy",

    "I want to stay motivated",

    "Overcome from trauma"
    // Add more goals if needed
  ];

  String selectedGoal = '';

  ReceivePort mindfullReceivePort = ReceivePort();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startMindfullBackgroundTimer();
  }

  Future<void> startMindfullBackgroundTimer() async {
    UserInformation _userInformation = Get.put(UserInformation());

    try {
      await Isolate.spawn(startMindfullTimer, mindfullReceivePort.sendPort);
      mindfullReceivePort.listen((data) {
        if (data % 9 == 0) {
          //convert data into minutes and update the user's mindfulness score
          _userInformation.meditaion_score.value = data ~/ 60;
        }
        print('mindfull Time elapsed: ${data ~/ 60} minutes');
        // Here you can store the elapsed time to a database or shared preferences
      });
    } on Object {
      print("Error in starting mindfull timer");
      mindfullReceivePort.close();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //remove Isolate thread
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                        builder: (context) => NewExercise2(
                              selectedGoal: selectedGoal,
                              receivePort: mindfullReceivePort,
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
                  border: Border.all(width: 2, color: Color(0xff0A0A0A)),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffd68ade),
                      ),
                      child: Text(
                        '1 of 3',
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
                "What's your mindful exercise goal?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff4F3422),
                  fontWeight: FontWeight.w800,
                  fontSize: 36,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: exerciseGoals.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                        selectedGoal = exerciseGoals[index];
                      });
                    },
                    child: Card(
                      color: _selectedIndex == index
                          ? Colors.green.withOpacity(0.3)
                          : null,
                      child: ListTile(
                        title: Text(exerciseGoals[index]),
                        selected: _selectedIndex == index,
                      ),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
              ),
            ),
            SizedBox(height: 80.0)
          ],
        ),
      ),
    );
  }
}

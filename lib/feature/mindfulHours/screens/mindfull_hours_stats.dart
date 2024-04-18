import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stress_sheild/feature/mindfulHours/screens/new_exercise.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/services/firebase_auth_service.dart';
import 'package:stress_sheild/global_widgets/ring_pieChart.dart';

final UserInformation _userInformation = Get.put(UserInformation());

class MindFullHoursStats extends StatelessWidget {
  MindFullHoursStats({super.key});

  //create a data map for the pie chart
  final Map<String, double> dataMap = {
    "Work": 5.21,
    "Rest": 3.21,
    "Play": 2.21,
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await _userInformation.fetchUserInformation();
          },
      child: Scaffold(
        floatingActionButton: //add floating action button with plus icon and green color make it to bottom center and make it size large
            FloatingActionButton.large(
          onPressed: () {
            // Add your onPressed code here!
            //navigate to new exercise page
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => NewExercise()));
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.green,
          elevation: 10,
          splashColor: Colors.blue,
          focusColor: Colors.red,
          hoverColor: Colors.yellow,
          tooltip: 'Add Mindful Hours',
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: const BorderSide(
              color: Color(0xFF35A84E20), // Translucent white border
              width: 5.0, // Adjust border width as needed
            ),
          ),
          materialTapTargetSize: MaterialTapTargetSize.padded,
          clipBehavior: Clip.antiAlias,
          // optional
          heroTag: null, // optional
          // Set the dimensions
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              //create a container with back top arrow and title, and a Pie_chart widget showing the mindful hours
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(width: 2, color: Colors.black),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            color: Colors.black,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        title: Text(
                          'Mindful Hours',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  //create a row which holds two Icon Button with icon setting and icon share

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PieChartSample2(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    ));
  }


}

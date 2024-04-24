import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                        title: Text(
                          textAlign: TextAlign.center,
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

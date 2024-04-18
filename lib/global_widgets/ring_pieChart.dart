import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/services/firebase_auth_service.dart';
import 'package:stress_sheild/global_widgets/indicatior.dart';



final UserInformation _userInformation = Get.put(UserInformation());

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Obx(() =>  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center( // Wrap the Column with Center widget
        child: Container(
          height: MediaQuery.of(context).size.height*0.8 ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(

                    PieChartData(

                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections(),
                    ),
                  ),
                ),
              ),

              //create a Container which shows 8.21 hours of mindful hours
              Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,

                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '8.21',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Mindful Hours',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RawMaterialButton(
                    onPressed: () {},
                    elevation: 2.0,
                    fillColor: Colors.white,
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(
                      side: BorderSide(color: Colors.black, width: 1.0),
                    ),
                    child: Icon(
                      Icons.settings,
                      color: Colors.black,
                      size: 24.0,
                    ),
                  ),
                  SizedBox(width: 16.0), // Adjust the space between buttons
                  RawMaterialButton(
                    onPressed: () {},
                    elevation: 2.0,
                    fillColor: Colors.white,
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(
                      side: BorderSide(color: Colors.black, width: 1.0),
                    ),
                    child: Icon(
                      Icons.share,
                      color: Colors.black,
                      size: 24.0,
                    ),
                  ),
                ],
              ),


              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Indicator(
                        color: Color(0xff003f5c),
                        text: 'MindFul Hours',
                        value: '${_userInformation.mindful_hours_score}', // Example value
                        isSquare: false,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xff444e86),
                        text: 'Chat Thearapy',
                        value: '${_userInformation.chatbot_score}', // Example value
                        isSquare: false,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xff955196),
                        text: 'Mood Rate',
                        value: '${_userInformation.mood_score}', // Example value
                        isSquare: false,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xffdd5182),
                        text: 'Audio',
                        value: '${_userInformation.audio_score}', // Example value
                        isSquare: false,
                      ), SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xffff6e54),
                        text: 'Article',
                        value: '${_userInformation.articles_scores}', // Example value
                        isSquare: false,
                      ),SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xffffa600),
                        text: 'Course',
                        value: '${_userInformation.course_score}', // Example value
                        isSquare: false,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                width: 28,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(6, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Color(0xff003f5c),
            value: _userInformation.mindful_hours_score.toDouble() == 0 ? 0 : (_userInformation.mindful_hours_score.toInt()/_userInformation.freud_score.toInt())*100,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Color(0xff444e86),
            value: _userInformation.chatbot_score.toDouble() == 0 ? 0 : (_userInformation.chatbot_score.toInt()/_userInformation.freud_score.toInt())*100,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Color(0xff955196),
            value: _userInformation.mood_score.toDouble() == 0 ? 0 : (_userInformation.mood_score.toInt()/_userInformation.freud_score.toInt())*100,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color:Colors.black,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Color(0xffdd5182),
            value: _userInformation.audio_score.toDouble() == 0 ? 0 : (_userInformation.audio_score.toInt()/_userInformation.freud_score.toInt())*100,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
          case 4:
          return PieChartSectionData(
            color: Color(0xffff6e54),
            value: _userInformation.articles_scores.toDouble() == 0 ? 0 : (_userInformation.articles_scores.toInt()/_userInformation.freud_score.toInt())*100,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
          case 5:
          return PieChartSectionData(
            color: Color(0xffffa600),
            value: _userInformation.course_score.toDouble() == 0 ? 0 : (_userInformation.course_score.toInt()/_userInformation.freud_score.toInt())*100,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stress_sheild/feature/mindfulHours/screens/new_exercise3.dart';
import 'package:wheel_picker/wheel_picker.dart';

class NewExercise2 extends StatefulWidget {
  const NewExercise2({super.key});

  @override
  State<NewExercise2> createState() => _NewExercise2State();
}

class _NewExercise2State extends State<NewExercise2> {
  Duration _duration = Duration(hours: 0, minutes: 0);
  final secondsWheel = WheelPickerController(itemCount: 59);
  final minutesWheel = WheelPickerController(itemCount: 59);
  static const textStyle = TextStyle(fontSize: 70, height: 1.5 , color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                        '2 of 3',
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewExercise3()));
          },
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "How much time do you have for exercise?",
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
                      // child: DurationPicker(
                      //   duration: _duration,
                      //   onChange: (val) {
                      //     setState(() => _duration = val);
                      //   },
                      //   snapToMins: 5.0,
                      // ),
                      child: Container(
                        padding: EdgeInsets.all(16),


                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Container(
                                  // width: MediaQuery.of(context).size.width * 0.8,

                                  padding: EdgeInsets.symmetric(horizontal: 25, ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(200),
                                    color: Color(0xff9BB167),
                                    border: Border.all(width: 7, color: Color(
                                        0xffE8DDD9).withOpacity(0.7)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: [WheelPicker(
                                      builder: (context, index) => Text("$index", style: textStyle),
                                      controller: secondsWheel,
                                      selectedIndexColor: Colors.white,
                                      onIndexChanged: (index) {
                                        print("On index $index");
                                      },
                                      style: WheelPickerStyle(

                                        itemExtent: textStyle.fontSize! * textStyle.height!, // Text height
                                        squeeze: 1.25,
                                        diameterRatio: .8,
                                        surroundingOpacity: 0,
                                        magnification: 1.2,
                                      ),
                                    ),
                                      Text(":", style: textStyle,),
                                      WheelPicker(
                                        builder: (context, index) => Text("$index", style: textStyle),
                                        controller: minutesWheel,

                                        selectedIndexColor: Colors.white,
                                        onIndexChanged: (index) {
                                          print("On index $index");
                                        },


                                        style: WheelPickerStyle(
                                          itemExtent: textStyle.fontSize! * textStyle.height!, // Text height
                                          squeeze: 1.25,
                                          diameterRatio: .8,
                                          surroundingOpacity: 0,
                                          magnification: 1.2,
                                        ),
                                      )],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            Text(
                              'Minutes',
                              style: TextStyle(
                                color: Color(0xff756D68),
                                fontSize: 32,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //create a Container with sound logo and text " sound: Chirping Birds" with color D2CECB and font size 24,make background color E8DDD9
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color(0xffE8DDD9),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.volume_up,
                                    color: Color(0xff756D68),
                                    size: 24,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Sound: Chirping Birds',
                                    style: TextStyle(
                                      color: Color(0xff9A6D54),
                                      fontSize: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
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
    );
  }
}

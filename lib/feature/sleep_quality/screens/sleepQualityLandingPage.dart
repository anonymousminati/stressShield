import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SleepQualityLandingPage extends StatefulWidget {
  const SleepQualityLandingPage({super.key});

  @override
  State<SleepQualityLandingPage> createState() =>
      _SleepQualityLandingPageState();
}

class _SleepQualityLandingPageState extends State<SleepQualityLandingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'images/crosssquarebluepattern.jpg',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              child: Column(
                children:[
                  //create a row with title and and back button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white), // Add border color
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back),
                            color: Colors.white, // Set the color of the icon
                          ),
                        ),
                        SizedBox(width: 10), // Add some spacing between the button and text
                        Text(
                          'Sleep Quality',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Set the color of the text
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,


                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("sleep cycle"),
                                  TextButton(onPressed: (){}, child: Text("see all"),)
                                ],
                              ),
                              _buildRangePointerExampleGauge()],
                          ),
                        )),
                        Expanded(child: Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("sleep cycle"),
                                  TextButton(onPressed: (){}, child: Text("see all"),)
                                ],
                              ),
                              _buildRangePointerExampleGauge()],
                          ),
                        ))
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

  SfRadialGauge _buildRangePointerExampleGauge() {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(

            showLabels: false,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: 0.8,
            axisLineStyle: const AxisLineStyle(
                thicknessUnit: GaugeSizeUnit.factor, thickness: 0.15),
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  angle: 180,
                  widget: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '8.5h',
                        style: TextStyle(
                            fontFamily: 'Times',
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  )),
            ],
            pointers: const <GaugePointer>[
              RangePointer(
                  value: 50,
                  cornerStyle: CornerStyle.bothCurve,
                  enableAnimation: true,
                  animationDuration: 1200,
                  sizeUnit: GaugeSizeUnit.factor,
                  gradient: SweepGradient(
                      colors: <Color>[Color(0xFF6A6EF6), Color(0xFFDB82F5)],
                      stops: <double>[0.25, 0.75]),
                  color: Color(0xFF00A8B5),
                  width: 0.15),
            ]),
      ],
    );
  }
}

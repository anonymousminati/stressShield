import 'package:flutter/material.dart';
import 'package:stress_sheild/global_widgets/reusable_material_button.dart';

class ReusableStepsScreen extends StatelessWidget {
  final int index;
  final List<String> text;
  final List<Color> colors;
  final List<double> fontSizes;
  final VoidCallback? onPress; // Added onPress parameter
  const ReusableStepsScreen({
    Key? key,
    required this.index,
    required this.text,
    required this.colors,
    required this.fontSizes,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFE5EAD7),
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'images/welcome_step${index + 1}.png',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(200, 90),
                          topRight: Radius.elliptical(200, 90),
                        ),
                        color: Color(0xFFFFFFFF),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 76),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: const BorderRadius.horizontal(
                                      left: Radius.circular(40),
                                      right: Radius.circular(40))),
                              child: Text(
                                'Step ${index + 1}',
                                style: TextStyle(
                                  color: Color(0xFF4F3422),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: 343,
                              child: Text.rich(
                                TextSpan(
                                  children: List.generate(text.length, (index) {
                                    return TextSpan(
                                      text: text[index],
                                      style: TextStyle(
                                        color: colors[index],
                                        fontSize: fontSizes[index],
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w800,
                                      ),
                                    );
                                  }),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 24),
                            ReusableButton(
                              icon: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                              onPressed: onPress ?? () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

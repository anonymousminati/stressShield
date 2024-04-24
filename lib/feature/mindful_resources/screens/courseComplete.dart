import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CourseComplete extends StatefulWidget {
  @override
  State<CourseComplete> createState() => _CourseCompleteState();
}

class _CourseCompleteState extends State<CourseComplete> {
  late final _ratingController;
  late double _rating;

  double _userRating = 3.0;
  int _ratingBarMode = 1;
  double _initialRating = 4.0;
  bool _isRTLMode = false;
  bool _isVertical = false;

  IconData? _selectedIcon;

  @override
  void initState() {
    super.initState();
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'images/growImprove.jpg',
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Course Complete!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  // Increase font size
                  color: Color(0xff4F3422),
                  // Change text color to black for better visibility
                  shadows: [
                    Shadow(
                      color: Colors.white,
                      blurRadius: 2,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Congrats! Do you feel enlightened?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  // Increase font size
                  color: Color(0xff726d69),
                  // Change text color to black for better visibility
                  shadows: [
                    Shadow(
                      color: Colors.white,
                      blurRadius: 2,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RatingBar.builder(
                initialRating: _initialRating,
                direction: _isVertical ? Axis.vertical : Axis.horizontal,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return Icon(
                        Icons.sentiment_very_dissatisfied,
                        color: Colors.red,
                        size: 50, // Adjust the size as needed
                      );
                    case 1:
                      return Icon(
                        Icons.sentiment_dissatisfied,
                        color: Colors.redAccent,
                        size: 50, // Adjust the size as needed
                      );
                    case 2:
                      return Icon(
                        Icons.sentiment_neutral,
                        color: Colors.amber,
                        size: 50, // Adjust the size as needed
                      );
                    case 3:
                      return Icon(
                        Icons.sentiment_satisfied,
                        color: Colors.lightGreen,
                        size: 50, // Adjust the size as needed
                      );
                    case 4:
                      return Icon(
                        Icons.sentiment_very_satisfied,
                        color: Colors.green,
                        size: 50, // Adjust the size as needed
                      );
                    default:
                      return Container();
                  }
                },
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
                updateOnDrag: true,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Rating: $_rating',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  // Increase font size
                  color: Colors.black,
                  // Change text color to black for better visibility
                  shadows: [
                    Shadow(
                      color: Colors.white,
                      blurRadius: 2,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //create a button with rounded border with text "Rate Session" and on click of button navigate to next screem use iconButton
              ElevatedButton(
                onPressed: () {
                  //TODO: add the rating of the course to the database
                  Navigator.pushNamed(context, 'ourCourses');
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 70.0),
                  backgroundColor: Color(0xff4F3422),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        30.0), // Adjust the border radius as needed
                  ), // Change the button color as needed
                ),
                child: Text(
                  'Rate Session',
                  style: TextStyle(
                    fontSize: 18.0, // Adjust the font size as needed
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Change the text color as needed
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}

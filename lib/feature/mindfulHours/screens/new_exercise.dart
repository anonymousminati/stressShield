import 'package:flutter/material.dart';

// import library
import 'package:stress_sheild/feature/mindfulHours/screens/new_exercise2.dart';

//class name
class NewExercise extends StatelessWidget {
  const NewExercise({Key? key}) : super(key: key);

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
        floatingActionButton: FloatingActionButton.extended(
          extendedPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2),          label: Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white)),
          icon: Icon(Icons.arrow_forward , color: Colors.white,),
          backgroundColor: Colors.brown,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewExercise2()),
            );
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
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  CustomCard(title: "I want to gain more Focus"),
                  CustomCard(title: "I want to sleep better"),
                  CustomCard(title: "I want to be a better person"),
                  CustomCard(title: "I want to conquer my trauma"),
                  CustomCard(title: "I want to enjoy my life"),
                  CustomCard(title: "I want to be a successful person"),
                  CustomCard(title: "I want to conquer my trauma"),
                  CustomCard(title: "I want to enjoy my life"),
                  CustomCard(title: "I want to be a successful person"),
                  CustomCard(title: "I want to conquer my trauma"),
                  CustomCard(title: "I want to enjoy my life"),
                  CustomCard(title: "I want to be a successful person"),

                ],
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

class CustomCard extends StatefulWidget {
  final String title;

  const CustomCard({Key? key, required this.title}) : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Card(
        color: _isSelected ? Colors.green : Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isSelected = !_isSelected;
                  });
                },
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _isSelected ? Colors.white : Colors.brown,
                      width: 2.0,
                    ),
                  ),
                  child: _isSelected
                      ? Center(
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  )
                      : null,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: _isSelected ? Colors.white : Colors.brown,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Scaffold(
// backgroundColor: Colors.white,
// appBar: PreferredSize(
// preferredSize: Size.fromHeight(kToolbarHeight +32), // Add 16.0 padding to the top and bottom of the AppBar
// child: Padding(
// padding: const EdgeInsets.all(16.0),
// child: AppBar(
// leading: Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(50),
// border: Border.all(width: 2, color: Color(0xff0A0A0A)),
// ),
// child: IconButton(
// icon: const Icon(Icons.arrow_back),
// color: Color(0xff4F3422),
// onPressed: () {
// Navigator.pop(context);
// },
// ),
// ),
// title: Padding(
// padding: const EdgeInsets.all(16.0),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text(
// 'New Exercise',
// style: TextStyle(
// color: Color(0xff4F3422),
// fontWeight: FontWeight.w800,
// fontSize: 24,
// ),
// ),
// Container(
// padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(20),
// color: Color(0xffd68ade),
// ),
// child: Text(
// '1 of 3',
// style: TextStyle(
// color: Color(0xff4F3422),
// fontWeight: FontWeight.w800,
// fontSize: 16,
// ),
// ),
// ),
// ],
// ),
// ),
// ),
// ),
// ),
//
// body: Stack(
// fit: StackFit.expand,
// children: [
//
// SingleChildScrollView(
// child: Column(
// children: [
//
// Padding(
// padding: const EdgeInsets.all(16.0),
// child: Text(
// "What's your mindful exercise goal?",
// textAlign: TextAlign.center,
// style: TextStyle(
// color: Color(0xff4F3422),
// fontWeight: FontWeight.w800,
// fontSize: 36,
// ),
// ),
// ),
// GridView.count(
// crossAxisCount: 2,
//
// shrinkWrap: true,
//
// children: [
// CustomCard(title: "I want to gain more Focus"),
// CustomCard(title: "I want to sleep better"),
// CustomCard(title: "I want to be a better person"),
// CustomCard(title: "I want to conquer my trauma"),
// CustomCard(title: "I want to enjoy my life"),
// CustomCard(title: "I want to be a successful person"),
// CustomCard(title: "I want to conquer my trauma"),
// CustomCard(title: "I want to enjoy my life"),
// CustomCard(title: "I want to be a successful person"),
// CustomCard(title: "I want to conquer my trauma"),
// CustomCard(title: "I want to enjoy my life"),
// CustomCard(title: "I want to be a successful person"),
// ],
// ),
//
// ],
// ),
// )
// ],
// ),
// ),

import 'package:flutter/material.dart';
import 'package:stress_sheild/feature/mindfulHours/screens/new_exercise2.dart';

class NewExercise extends StatefulWidget {
  const NewExercise({Key? key}) : super(key: key);

  @override
  _NewExerciseState createState() => _NewExerciseState();
}

class _NewExerciseState extends State<NewExercise> {
  int _selectedIndex = -1; // Initially no card is selected

  List<String> exerciseGoals = [
    "goal1",
    "goal2",
    "goal3",
    // Add more goals if needed
  ];


  String selectedGoal = '';

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
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
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
          extendedPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2),
          label: Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          icon: Icon(Icons.arrow_forward , color: Colors.white,),
          backgroundColor: Colors.brown,
          onPressed: _selectedIndex != -1 ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewExercise2(selectedGoal: selectedGoal)),
              );
            } : null,

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
                      color: _selectedIndex == index ? Colors.green.withOpacity(0.3) : null,
                      child: ListTile(
                        title: Text(exerciseGoals[index]),
                        selected: _selectedIndex == index,
                      ),
                    ),
                  );
                }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

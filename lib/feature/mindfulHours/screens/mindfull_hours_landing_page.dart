import 'package:flutter/material.dart';
import 'package:stress_sheild/feature/mindfulHours/screens/mindfull_hours_stats.dart';

class MindFullHoursLandingPage extends StatelessWidget {
  const MindFullHoursLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // Set background color to transparent
        // appBar: TopAppBar(),
        //create a floating action button with a plus icon and make it large and float center without any title
        floatingActionButton: FloatingActionButton.large(
          onPressed: () {
            // Add your onPressed code here!
            //navigate to mindful hours stat page
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MindFullHoursStats()));
          },
          child: const Icon(Icons.add),
          backgroundColor: Color(0xff4F3422),
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

        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              './images/GrayBg.jpg',
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
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
                            border: Border.all(width: 2, color: Colors.white),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        title: Text(
                          'Mindful Hours',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '5.21',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 100,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Hours',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          MindFullHoursHistoryTiles(
                            title: 'Mindful Hours',
                            subtitle: '8/25min',
                            label: 'Nature',
                            labelColor:
                                Colors.green, // specify label color here
                          ),
                          MindFullHoursHistoryTiles(
                            title: 'Reading Time',
                            subtitle: '5/30min',
                            label: 'Reading',
                            labelColor: Colors.green,
                          ),
                          MindFullHoursHistoryTiles(
                            title: 'Exercise Session',
                            subtitle: '10/45min',
                            label: 'Workout',
                            labelColor: Colors.red,
                          ),
                          MindFullHoursHistoryTiles(
                            title: 'Study Break',
                            subtitle: '3/20min',
                            label: 'Relaxation',
                            labelColor: Colors.purple,
                          ),
                          MindFullHoursHistoryTiles(
                            title: 'Mindful Hours',
                            subtitle: '8/25min',
                            label: 'Nature',
                            labelColor: Colors.green,
                          ),
                          MindFullHoursHistoryTiles(
                            title: 'Reading Time',
                            subtitle: '5/30min',
                            label: 'Reading',
                            labelColor: Colors.green,
                          )
                        ],
                      ),
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
}

class MindFullHoursHistoryTiles extends StatelessWidget {
  final String title;
  final String subtitle;
  final String label;
  final Color labelColor;

  const MindFullHoursHistoryTiles({
    required this.title,
    required this.subtitle,
    required this.label,
    this.labelColor = Colors.brown,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 2, color: Colors.black),
        ),
        child: IconButton(
          icon: const Icon(Icons.play_arrow),
          color: Colors.black,
          onPressed: () {
            // Navigator.pop(context);
          },
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontSize: 24,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
      trailing: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: labelColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent, // Make AppBar transparent
      elevation: 0, // Remove shadow
      leading: Container(
        // Customize leading icon button
        margin: EdgeInsets.all(12), // Adjust margin for size
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white), // Add round border
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          iconSize: 24, // Set icon size to 24
        ),
      ),
      title: Text(
        'Mindful Hours',
        style: TextStyle(
          color: Colors.white, // Make title white
          fontWeight: FontWeight.bold, // Make title bold
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

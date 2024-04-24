import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stress_sheild/global_widgets/notification_tile.dart';
import 'package:stress_sheild/feature/smart_notification/screens/show_notification.dart';

class NotificationLandingPage extends StatelessWidget {
  const NotificationLandingPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              color: Color(0xFFE5E5E5),
              width: double.infinity,
              height: double.infinity,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //create container act as a app bar with backbutton with background transparent and round border
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Color(0xFF4F3422)),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Color(0xFF4F3422),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                  //create a container with text "notification" , label "11+" and a profile picture with background white
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Notification",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFC89E),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "11+",
                            style: TextStyle(
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        CircleAvatar(
                          radius: 40,
                          child: SvgPicture.asset(
                            'assets/icons/profileUser.svg',
                            width: 130.0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //create a row with text "new" and three dot button
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "New",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF4F3422),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.grey,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _notificationData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NotificationTile(
                          leadingIcon: _notificationData[index]['leadingIcon'],
                          leadingBackgroundColor: _notificationData[index]
                              ['leadingBackgroundColor'],
                          title: _notificationData[index]['title'],
                          subtitle: _notificationData[index]['subtitle'],
                          notificationData: _notificationData[index]
                              ['notification_data'],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 10);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> _notificationData = [
  {
    'leadingIcon': Icons.android,
    'leadingBackgroundColor': Color(0xFF9BB167),
    'title': "Message from Dr Freud AI!",
    'subtitle': "52 total unread messages",
    'notification_data': {
      'imagePath': 'images/notification.jpg',
      'mainTitle': '+8',
      'title': 'Freud Score increased',
      'description': 'You\'re 26% happier compared to last month. Congrats!',
      'nextNavigation': 'landingHomePage', // Example navigation route
    },
  },
  {
    'leadingIcon': Icons.notifications,
    'leadingBackgroundColor': Colors.blue,
    'title': "New Update Available",
    'subtitle': "Tap to install the latest version.",
    'notification_data': {
      'imagePath': 'images/notification.jpg',
      'mainTitle': 'App Update',
      'title': 'New Version Available',
      'description': 'A new update for the app is available. Tap to install.',
      'nextNavigation': '/update', // Example navigation route
    },
  },
  {
    'leadingIcon': Icons.email,
    'leadingBackgroundColor': Colors.orange,
    'title': "New Email Received",
    'subtitle': "You have a new message from John Doe.",
    'notification_data': {
      'imagePath': 'images/notification.jpg',
      'mainTitle': 'Email Notification',
      'title': 'New Email Received',
      'description': 'You have received a new email from John Doe.',
      'nextNavigation': '/email', // Example navigation route
    },
  },
  {
    'leadingIcon': Icons.calendar_today,
    'leadingBackgroundColor': Colors.purple,
    'title': "Meeting Reminder",
    'subtitle': "Don't forget about the team meeting at 3 PM.",
    'notification_data': {
      'imagePath': 'images/notification.jpg',
      'mainTitle': 'Meeting Reminder',
      'title': 'Team Meeting',
      'description': "Don't forget about the team meeting at 3 PM today.",
      'nextNavigation': '/meeting', // Example navigation route
    },
  },
  {
    'leadingIcon': Icons.info,
    'leadingBackgroundColor': Colors.teal,
    'title': "Important Announcement",
    'subtitle': "Please review the latest company policy updates.",
    'notification_data': {
      'imagePath': 'images/notification.jpg',
      'mainTitle': 'Announcement',
      'title': 'Important Update',
      'description': 'Please review the latest company policy updates.',
      'nextNavigation': '/announcement', // Example navigation route
    },
    "trailing": Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      child: Center(
        child: Text(
          '8/23',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  },
];

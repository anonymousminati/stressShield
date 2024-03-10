import 'package:flutter/material.dart';
import 'package:stress_sheild/feature/smart_notification/screens/show_notification.dart';

class NotificationTile extends StatelessWidget {
  final IconData leadingIcon;
  final Color leadingBackgroundColor;
  final String title;
  final String subtitle;
  final Map<String, dynamic> notificationData;

  const NotificationTile({
    Key? key,
    required this.leadingIcon,
    required this.leadingBackgroundColor,
    required this.title,
    required this.subtitle,
    required this.notificationData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowNotification(
              imagePath: notificationData['imagePath'],
              mainTitle: notificationData['mainTitle'],
              title: notificationData['title'],
              description: notificationData['description'],
              buttonText: 'Next', // You can customize this if needed
              buttonIcon: Icons.arrow_forward,
              onNextNavigation: (){
                Navigator.pushNamed(context, notificationData['nextNavigation']);
              },
              // You can customize this if needed
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: leadingBackgroundColor,
            child: Icon(
              leadingIcon,
              color: Colors.white,
              size: 24,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF4F3422),
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

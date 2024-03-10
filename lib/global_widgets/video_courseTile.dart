import 'package:flutter/material.dart';

class VideoCourseTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final Color color;
  final Color headingColor;
  final Color subheadingColor;
  final Function()? onPress;

  VideoCourseTile({
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.headingColor = const Color(0xFF4F3422),
    this.subheadingColor = const Color(0xFF8E8A86),
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(15.0),
          leading: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 40.0,

               child: ClipRRect(
                 borderRadius: BorderRadius.circular(50.0),

                 child: Image.asset(
                   'images/jungle.jpg',
                    fit: BoxFit.fill,

                 ),
               ),
              ),
              Icon(
                Icons.play_circle_filled,
                size: 40.0,
                color: Colors.brown,
              ),
            ],
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: headingColor,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: subheadingColor,
                ),
              ),
              SizedBox(height: 5.0),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 20.0,
                    color: Colors.amber,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    '4.5', // Replace with star rating value
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Icon(
                    Icons.remove_red_eye,
                    size: 20.0,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    '100k', // Replace with views count
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
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

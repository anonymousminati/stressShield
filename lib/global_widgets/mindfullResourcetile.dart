import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MindFullResourceCard extends StatelessWidget {
  final String titleImg;
  final String title;
  final String description;
  final int likes;
  final int views;

  const MindFullResourceCard({
    Key? key,
    required this.titleImg,
    required this.title,
    required this.description,
    required this.likes,
    required this.views,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: 230,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: SvgPicture.asset(
                  titleImg,
                  width: 60.0,
                ),
              ),
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFEC7D1C),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                description,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        color: Color(0xFFEC7D1C),
                      ),
                      Text(
                        '  $likes Likes',
                        style: TextStyle(
                          color: Color(0xFFEC7D1C),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.remove_red_eye,
                        color: Color(0xFFEC7D1C),
                      ),
                      Text(
                        '  $views Views',
                        style: TextStyle(
                          color: Color(0xFFEC7D1C),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

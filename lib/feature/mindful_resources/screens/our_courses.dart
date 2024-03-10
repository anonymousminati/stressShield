import 'package:flutter/material.dart';
import 'package:stress_sheild/feature/mindful_resources/screens/OurResources.dart';
import 'package:stress_sheild/feature/mindful_resources/screens/article.dart';
import 'package:stress_sheild/feature/smart_notification/screens/notification_landingPage.dart';
import 'package:stress_sheild/global_widgets/audio/audioplayer%20widget.dart';
import 'package:stress_sheild/global_widgets/audio/firebaseStorageService.dart';
import 'package:stress_sheild/global_widgets/dynamic_article_card.dart';
import 'package:stress_sheild/global_widgets/youtubePlayer.dart';

class OurCourses extends StatefulWidget {
   OurCourses({super.key});

  @override
  State<OurCourses> createState() => _OurCoursesState();
}

class _OurCoursesState extends State<OurCourses> {
  final firebaseStorageService = FirebaseStorageService();
  // late  String audioUrl;
Future<String> getAudioUrl(String filename) async {
    final url = await firebaseStorageService.getAudioUrl(filename);
    return url;
}
  void initState()  {
    super.initState();
}

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Color(0xFFE5E5E5),
              width: double.infinity,
              height: double.infinity,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFED7E1C),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              //create date and a notification icon and make them space between
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      size: 24.0,
                                      color: Colors.white,
                                    ),
                                    iconSize: 24.0,
                                    // Adjust the icon size as needed
                                    padding: EdgeInsets.zero,
                                    // Remove any default padding
                                    constraints: BoxConstraints(),
                                    // Remove any default constraints
                                    splashRadius:
                                        24.0, // Adjust the splash radius as needed
                                    // You can also add other properties like tooltip, alignment, etc. if needed
                                  ),
                                ),
                                Container(
                                  width: 50.0,
                                  height: 50.0,
                                  padding: EdgeInsets.all(2.0),
                                  // Adjust padding as needed
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NotificationLandingPage()),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.notifications,
                                      size: 24.0,
                                      color: Colors.white,
                                    ),
                                    splashRadius:
                                        24.0, // Adjust the splash radius as needed
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            //create a profile picture and user name text. below that show score:80% and text"happy"
                            Text(
                              'Our Courses',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  size: 24.0,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '512 Courses',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Featured Courses',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4E3321),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Add your onPressed functionality here
                              },
                              child: Icon(
                                Icons.more_vert,
                                size: 24.0,
                                color: Color(0xFF4E3321),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        //create a Youtube Video Player
                    YouTubePlayerWidget(videoUrl: 'https://www.youtube.com/watch?v=8OVh5HzCWYE', videoTitle: 'shree krishn gyan_life lesson | bhagwat Gita | vani', creatorName: 'Krishna',)


                    ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Our Courses',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4E3321),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                              },
                              child: Icon(
                                Icons.more_vert,
                                size: 24.0,
                                color: Color(0xFF4E3321),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ListOfOurCources(),
                    ],
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

class IconTextItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color backgroundColor;

  const IconTextItem({
    required this.icon,
    required this.text,
    Key? key,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Icon(
              icon,
              size: 24.0,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

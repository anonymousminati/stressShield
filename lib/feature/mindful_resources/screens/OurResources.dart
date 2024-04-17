import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/landing_home_page.dart';
import 'package:stress_sheild/feature/mindful_resources/screens/course.dart';
import 'package:stress_sheild/feature/mindful_resources/screens/our_article.dart';
import 'package:stress_sheild/feature/smart_notification/screens/notification_landingPage.dart';
import 'package:stress_sheild/global_widgets/articleList.dart';
import 'package:stress_sheild/global_widgets/courseList.dart';
import 'package:stress_sheild/global_widgets/mindfullResourcetile.dart';
import 'package:stress_sheild/global_widgets/video_courseTile.dart';
import 'package:stress_sheild/model/dataModels.dart';
import 'package:stress_sheild/router.dart';

class OurResources extends StatelessWidget {
  const OurResources({super.key});

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
                    padding: EdgeInsets.only(top: 20 ,bottom: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFF4F3422),
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
                              'Our Resources',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            //create a Row which has icon and text "184 Article" and another icon and text "12 Video"
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.article,
                                        size: 24.0,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        '184 Articles',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Icon(Icons.circle, color: Colors.white,size: 5,),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Container(

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.video_library,
                                        size: 24.0,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        '12 Videos',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
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
                              'Featured Resources',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.more_horiz,
                              size: 40.0,
                            ),
                          ],
                        ),
                        Card(
                          // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          // Set the clip behavior of the card
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          // Define the child widgets of the card
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
                              Image.asset(
                                'images/meditation.jpg',
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              // Add a container with padding that contains the card's title, text, and buttons
                              Container(
                                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Display the card's title using a font size of 24 and a dark grey color
                                    Text(
                                      "Mental Health",
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    // Add a space between the title and the text
                                    Container(height: 10),
                                    // Display the card's text using a font size of 15 and a light grey color
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            softWrap: true,
                                            "Freud App: Your Pocket Therapist for mental Wellness",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ),
                                        //create a Icon Button with next arrow and make it round
                                        Container(
                                          width: 50.0,
                                          height: 50.0,
                                          padding: EdgeInsets.all(2.0),
                                          // Adjust padding as needed
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50.0),
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1.0,
                                            ),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              // Add your onPressed functionality here
                                            },
                                            icon: Icon(
                                              Icons.arrow_forward,
                                              size: 24.0,
                                              color: Colors.grey,
                                            ),
                                            splashRadius:
                                            24.0, // Adjust the splash radius as needed
                                          ),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                              Container(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Our Articles',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              //create "view all" button
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => OurArticle()));
                                },
                                child: Text(
                                  'View All',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color(0xFF4F3422),
                                  ),
                                ),
                              )
                              ,
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ArticleListViewBuilder(),
                        ],
                      ),
                    ),
                  ),

      Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Our Courses',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'ourCourses');
                    },
                    child: Icon(
                      Icons.more_horiz,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),

              CourseListViewBuilder()
              // ListOfOurCources(), // Use the customListTile directly
            ],
          ),
        ),
      ),

                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
//
//
// class ListOfOurCources extends StatelessWidget {
//   const ListOfOurCources({Key? key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children:courseData.map((course) {
//         return VideoCourseTile(
//           leadingIcon: Icons.accessibility_new,
//           title: course['CourseTitle'],
//           subtitle: course['CourseLevel'],
//           color: Color(0xFF926247),
//           headingColor: Color(0xFF926247),
//           subheadingColor: Color(0xFF926247),
//           onPress: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => Course(course: course),
//               ),
//             );
//           },
//         );
//       }).toList(),
//     );
//   }
// }




//
// Card(
// // Define the shape of the card
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(4),
// ),
// // Define how the card's content should be clipped
// clipBehavior: Clip.antiAliasWithSaveLayer,
// // Define the child widget of the card
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// // Add padding around the row widget
// Padding(
// padding: const EdgeInsets.all(15),
// child: Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// // Add an image widget to display an image
// Image.asset(
// "images/meditation.jpg",
// height: 100,
// width: 100,
// fit: BoxFit.cover,
// ),
// // Add some spacing between the image and the text
// Container(width: 20),
// // Add an expanded widget to take up the remaining horizontal space
// Expanded(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// // Add some spacing between the top of the card and the title
// Container(height: 5),
// // Add a title widget
// Text(
// "Mental Health",
// style:TextStyle(
// fontSize: 20.0,
// fontWeight: FontWeight.w600,
// ),
// ),
// // Add some spacing between the title and the subtitle
// Container(height: 5),
// // Add a subtitle widget
// Text(
// "Freud App: Your Pocket Therapist for mental Wellness",
// style: TextStyle(
// fontSize: 14.0,
// color: Colors.grey[700],
// ),
// ),
// // Add some spacing between the subtitle and the text
// Container(height: 10),
// // Add a text widget to display some text
// //create Icon Button with next arrow and make it round
// Container(
// width: 50.0,
// height: 50.0,
// padding: EdgeInsets.all(2.0),
// // Adjust padding as needed
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(50.0),
// border: Border.all(
// color: Colors.grey,
// width: 1.0,
// ),
// ),
// child: IconButton(
// onPressed: () {
// // Add your onPressed functionality here
// },
// icon: Icon(
// Icons.arrow_forward,
// size: 24.0,
// color: Colors.grey,
// ),
// splashRadius:
// 24.0, // Adjust the splash radius as needed
// ),
// ),
// ],
// ),
// ),
// ],
// ),
// ),
// ],
// ),
// ),
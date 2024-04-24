import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/customnavbar.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/services/firebase_auth_service.dart';
import 'package:stress_sheild/feature/smart_notification/screens/notification_landingPage.dart';

final UserInformation _userInformation = Get.put(UserInformation());

class Article extends StatefulWidget {
  Article({super.key, required this.data});

  //create a parameter which will take map of a article
  final Map<String, dynamic> data;

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  Widget _popup() {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Image.asset('images/popup (2).jpg'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Well Done!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4F3422),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'You have successfully completed the Task. You have earned 5 points.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Color(0xFF4F3422),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: TextButton.icon(
                    onPressed: () {
                      var addScore = 5;
                      _userInformation.freud_score.value += addScore;
                      print(
                          'Freud Score: ${_userInformation.freud_score.value}');
                      _userInformation.articles_scores.value += addScore;
                      print(
                          'Articles Score: ${_userInformation.articles_scores}');
                      _userInformation.uploadUserInformation();
                      // Handle 'Mark as Read' button press
                      print('Mark as Read Pressed!');
                      _userInformation.fetchUserInformation();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavWithAnimations()),
                          (route) => false);
                    },
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Great. Thanks!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> articleContainers = [];
    if (widget.data != null &&
        widget.data.isNotEmpty &&
        widget.data['full_desc'] != null) {
      for (var article in widget.data['full_desc']) {
        articleContainers.add(
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article['title'] ?? '', // Add null check for 'title'
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  article['content'] ?? '', // Add null check for 'content'
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 18,
                    wordSpacing: 1.5,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
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
                              Text(
                                'Article',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
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
                          //create a Row with Text "Article" and "Phylosophy"
                          SizedBox(
                            height: 50.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  // Adjust padding as needed
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white, // Border color
                                      width: 1, // Border width
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        25), // Border radius
                                  ),
                                  child: Text(
                                    "Article",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                // Add spacing between the two texts
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  // Adjust padding as needed
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white, // Border color
                                      width: 1, // Border width
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        25), // Border radius
                                  ),
                                  child: Text(
                                    "Philosophy",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),

                          Text(
                            widget.data['article_title'],
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),

                          //create Row with star rating , views, comments. use logos for each add dot between them
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //create a Row with star rating , views, comments. use logos for each add dot between them
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.data['stars'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.remove_red_eye_rounded,
                                color: Colors.green[400],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.data['views'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.comment,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.data['comments'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        widget.data['img_url'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.data['img_caption'],
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: articleContainers,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  // Adjust padding as needed
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return _popup();
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF4F3422), // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.all(20),
                      // Adjust padding as needed
                    ),
                    child: Text(
                      'Mark as Read',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

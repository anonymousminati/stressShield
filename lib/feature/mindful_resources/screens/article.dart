import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stress_sheild/feature/smart_notification/screens/notification_landingPage.dart';
import 'package:stress_sheild/model/dataModels.dart';

class Article extends StatelessWidget {
   Article({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> articleContainers = [];
    if (articles_data != null &&
        articles_data.isNotEmpty &&
        articles_data[0]['sections'] != null) {
      for (var article in articles_data[0]['sections']) {
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
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12 ,vertical: 4),
                                // Adjust padding as needed
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white, // Border color
                                    width: 1, // Border width
                                  ),
                                  borderRadius:
                                  BorderRadius.circular(25), // Border radius
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
                                padding: EdgeInsets.symmetric(horizontal: 12 ,vertical: 4),
                                // Adjust padding as needed
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white, // Border color
                                    width: 1, // Border width
                                  ),
                                  borderRadius:
                                  BorderRadius.circular(25), // Border radius
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
                              articles_data[0]['article_title']
                              ,
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
                                articles_data[0]['stars'],
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
                                articles_data[0]['views'],
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
                                articles_data[0]['comments'],
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          //create a container with text "By: John Doe" and a profile picture with background white. make follow button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: CircleAvatar(
                                      radius: 30.0,
                                      child: SvgPicture.asset(
                                        'assets/icons/profileUser.svg',
                                        width: 60.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    'Tiya Jagtap',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                width: 20.0,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12 ,vertical: 4),
                                // Adjust padding as needed
                                decoration: BoxDecoration(
                                  color: Colors.white, // Border color
                                  borderRadius:
                                  BorderRadius.circular(25), // Border radius
                                ),
                                child: Text(
                                  "Follow",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF4F3422),
                                  ),
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
                      articles_data[0]['images'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    articles_data[0]['image_caption'],
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
        )
                //make a for loop and create a container with heading and description. check how many conter are there in the list and create that many containers

              ],
            )),
          ],
        ),
      ),
    );


  }
}

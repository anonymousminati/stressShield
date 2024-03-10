
import 'package:flutter/material.dart';
import 'package:stress_sheild/feature/mindful_resources/screens/article.dart';
import 'package:stress_sheild/feature/smart_notification/screens/notification_landingPage.dart';
import 'package:stress_sheild/global_widgets/dynamic_article_card.dart';

class OurArticle extends StatelessWidget {
  const OurArticle({super.key});

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
                    color: Color(0xFF9BB167),
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
                            'Our Article',
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
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.0,
                                blurRadius: 40,
                                offset: Offset(0, 3),
                              ),
                            ]),
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(15.0),
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                            suffixIcon: Icon(
                              Icons.search,
                              size: 40.0,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
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
                            'Suggested Categories',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Add your onPressed functionality here
                            },
                            child: Text(
                              'See All',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4F3422),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      //create a horizontal scrollable list of categories. show icons and below icons show text
                      SizedBox(
                        height: 110.0,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            IconTextItem(
                              icon: Icons.face,
                              text: 'Stress',
                              backgroundColor: Color(0xFF4F3422),
                            ),
                            IconTextItem(
                              icon: Icons.timer_rounded,
                              text: 'Anxiety',
                              backgroundColor: Color(0xFFAF9CF4),
                            ),
                            IconTextItem(
                              icon: Icons.cases,
                              text: 'Healthy',
                              backgroundColor: Color(0xFFED7E1C),
                            ),
                            IconTextItem(
                              icon: Icons.water_drop,
                              text: 'Status',
                              backgroundColor: Color(0xFFF2C04C),
                            ),
                            IconTextItem(
                              icon: Icons.health_and_safety,
                              text: 'Health',
                              backgroundColor: Color(0xFFC0A091),
                            ),
                            IconTextItem(
                              icon: Icons.remove_red_eye,
                              text: 'Emotion',
                              backgroundColor: Color(0xFF70B658),
                            ),
                          ],
                        ),
                      ),
                      )
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'All Articles',
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
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _articleData.length  ,

                        itemBuilder: (context, index) {
                          return _articleData[index];
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10.0,
                          );
                        },

                      ),
                      SizedBox(
                        height: 20.0,

                      )
                    ],
                  ),
                ),
              ],
            ),),
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
              color:backgroundColor,
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


//create ArticleCard variable to use in ListView.separated
final List<DynamicCard> _articleData = [
  DynamicCard(
    image: 'images/meditation.jpg',
    title: 'Introduction to Meditation',
    description: 'Beginner Level',
    onPress: 'article',
  ),
  DynamicCard(
    image: 'images/mindfulness.jpg',
    title: 'Mindful Living',
    description: 'Intermediate Level',
    onPress: "article",
  ),
  DynamicCard(
    image: 'images/sleep.jpg',
    title: 'Better Sleep Habits',
    description: 'Advanced Level',
    onPress: "article",
  ),
];

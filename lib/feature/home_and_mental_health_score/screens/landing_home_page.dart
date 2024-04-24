import 'package:card_slider/card_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stress_sheild/feature/aiTherapyChatbot/screen/detectorHome.dart';
import 'package:stress_sheild/feature/aiTherapyChatbot/screen/faceDetection.dart';
import 'package:stress_sheild/feature/aiTherapyChatbot/screen/resultScreen.dart';
import 'package:stress_sheild/feature/audio_therapy/music_player.dart';
import 'package:stress_sheild/feature/chatBot/screens/chatScreen.dart';
import 'package:stress_sheild/feature/communityChat/pages/community_chat_landing_page.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/mindful_activities.dart';
import 'package:stress_sheild/feature/mindfulHours/screens/mindfull_hours_landing_page.dart';
import 'package:stress_sheild/feature/mindfulHours/screens/new_exercise.dart';
import 'package:stress_sheild/feature/mindful_resources/screens/OurResources.dart';
import 'package:stress_sheild/feature/mindful_resources/screens/our_article.dart';
import 'package:stress_sheild/feature/mindful_resources/screens/our_courses.dart';
import 'package:stress_sheild/feature/profile/acountSettings.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/services/firebase_auth_service.dart';
import 'package:stress_sheild/feature/smart_notification/screens/notification_landingPage.dart';
import 'package:stress_sheild/feature/audio_therapy/songs.dart';
import 'package:stress_sheild/feature/smart_notification/screens/notification_page.dart';
import 'package:stress_sheild/global_widgets/mindfullResourcetile.dart';

final UserInformation _userInformation = Get.put(UserInformation());

class LandingHomePage extends StatefulWidget {
  LandingHomePage({super.key});

  @override
  State<LandingHomePage> createState() => _LandingHomePageState();
}

class _LandingHomePageState extends State<LandingHomePage> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EE').format(now);
    String formattedTime = DateFormat('h:mm a').format(now);
    return RefreshIndicator(
      onRefresh: _userInformation.fetchUserInformation,
      child: Scaffold(
        floatingActionButtonLocation: CustomFloatingActionButtonLocation(100),
        floatingActionButton: FloatingActionButton(
          heroTag: "chatBotFloatingButton",
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChatBotChatScreen()));
          },
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          tooltip: 'AI Therapist',
          child: Icon(
            Icons.adb_outlined,
            color: Colors.white,
          ),
          backgroundColor: Color(0xFFEC7D1C),
        ),
        body: SafeArea(
          child: Stack(fit: StackFit.expand, children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  //first above part
                  LandingprofileContainer(
                    formattedDate: formattedDate,
                    formattedTime: formattedTime,
                    userInformation: _userInformation.userInformation,
                  ),
                  //second part slider
                  MentalHealthSliderContainer(
                      scrollController: _scrollController),

                  MindfulTrackerContainer(
                      mindfulTrackerCustomListTile: ListOfMindfullTracker()),

                  //Ai therapist
                  AiTherapistContainer(),

                  //mindfull resources

                  MindfulResourceContainer(),
                ],
              )),
            ),
          ]),
        ),
        // bottomNavigationBar: BottomNavigationBar(),
        // bottomNavigationBar:   NavigationBar(
        //   destinations: [
        //     NavigationDestination(
        //       icon: IconButton(
        //         icon: Icon(Icons.home),
        //         onPressed: () {
        //           Navigator.push(context,
        //               MaterialPageRoute(builder: (_) => BottomNavWithAnimations()));
        //         },
        //       ),
        //       label: 'Home',
        //     ),
        //     NavigationDestination(
        //       icon:IconButton(
        //         icon: Icon(Icons.chat),
        //         onPressed: () {
        //           Navigator.push(context,
        //               MaterialPageRoute(builder: (_) =>  CommunityChatLandingPage()));
        //         },
        //       ),
        //       label: 'chat',
        //     ),
        //     NavigationDestination(
        //       icon:IconButton(
        //         icon: Icon(Icons.person),
        //         onPressed: () {
        //           Navigator.push(context,
        //               MaterialPageRoute(builder: (_) =>  AccountSettings()));
        //         },
        //       ),
        //       label: 'Profile',
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

class ListOfMindfullTracker extends StatelessWidget {
  const ListOfMindfullTracker({Key? key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            CustomListTile(
              leadingIcon: Icons.accessibility_new,
              title: 'Meditation',
              subtitle: '${_userInformation.meditaion_score} minutes',
              trailingIcon: Icons.arrow_forward_ios,
              color: Color(0xFFA694F5),
              headingColor: Color(0xFF2ACAD9),
              subheadingColor: Color(0xFF2ACAD9),
              onPress: () {},
            ),
            CustomListTile(
              leadingIcon: Icons.schedule,
              title: 'Mindful Hours',
              subtitle: '${_userInformation.mindfulness_score}min Today',
              trailingIcon: Icons.timer,
              color: Color(0xFF9BB167),
              headingColor: Color(0xFFB2B60F),
              subheadingColor: Color(0xFFB2B60F),
              onPress: () {},
            ),
            // CustomListTile(
            //   leadingIcon: Icons.bedtime,
            //   title: 'Sleep Quality',
            //   subtitle: 'Insomniac (~2hrAvg)',
            //   trailingIcon: Icons.nights_stay,
            //   color: Color(0xFFA694F5),
            //   headingColor: Color(0xFFC86E6E),
            //   subheadingColor: Color(0xFFC86E6E),
            //   onPress: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => MindfulActivities()),
            //     );
            //   },
            // ),
            // CustomListTile(
            //   leadingIcon: Icons.book,
            //   title: 'Mindful Journal',
            //   subtitle: '64 Day Streak',
            //   trailingIcon: Icons.assignment,
            //   color: Color(0xFFED7E1C),
            //   headingColor: Color(0xFF6E6EC8),
            //   subheadingColor: Color(0xFF6E6EC8),
            //   onPress: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => MindfulActivities()),
            //     );
            //   },
            // ),
            CustomListTile(
              leadingIcon: Icons.favorite,
              title: 'Mood',
              subtitle: '${_userInformation.mood_label}',
              trailingIcon: Icons.mood,
              color: Color(0xFFFFBD19),
              headingColor: Color(0xFF6E6EC8),
              subheadingColor: Color(0xFF6E6EC8),
              onPress: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => DummyContainer()),
                // );
              },
            ),
            CustomListTile(
              leadingIcon: Icons.face,
              title: 'Chatty Community',
              subtitle: '${_userInformation.mindfulness_score} minutes',
              trailingIcon: Icons.emoji_emotions,
              color: Color(0xFF926247),
              headingColor: Color(0xFF6E6EC8),
              subheadingColor: Color(0xFF6E6EC8),
              onPress: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => MindfulActivities()),
                // );
              },
            ),
            CustomListTile(
              leadingIcon: Icons.audio_file_outlined,
              title: 'Trending Audio',
              subtitle: '${_userInformation.trending_song} ',
              trailingIcon: Icons.audiotrack,
              color: Color(0xFFA694F5),
              headingColor: Color(0xFFC86E6E),
              subheadingColor: Color(0xFFC86E6E),
              onPress: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => MindfulActivities()),
                // );
              },
            ),
          ],
        ));
  }
}

class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: GNav(
            rippleColor: Colors.grey.shade200,
            // tab button ripple color when pressed
            hoverColor: Colors.grey.shade700,
            // tab button hover color
            haptic: true,
            // haptic feedback
            tabBorderRadius: 15,
            tabActiveBorder: Border.all(color: Colors.black, width: 1),
            // tab button border
            // tabBorder: Border.all(color: Colors.grey, width: 1), // tab button border
            // tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)], // tab button shadow
            curve: Curves.linear,
            // tab animation curves
            duration: Duration(milliseconds: 300),
            // tab animation duration
            gap: 8,
            // the tab button gap between icon and text
            color: Colors.grey[500],
            // unselected icon color
            activeColor: Colors.brown,
            // selected icon and text color
            iconSize: 24,
            // tab button icon size
            tabBackgroundColor: Colors.grey.withOpacity(0.1),
            // selected tab background color
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            // navigation bar padding
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.chat_bubble,
                text: 'Chat',
              ),
              GButton(
                icon: Icons.analytics_outlined,
                text: 'Score',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              )
            ]),
      ),
    );
  }
}

class MindfulResourceContainer extends StatelessWidget {
  const MindfulResourceContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mindful Resources',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: [
            //       GestureDetector(
            //         onTap: (){
            //           Navigator.push(context, MaterialPageRoute(builder: (context) => OurResources()));
            //         },
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: MindFullResourceCard(
            //             titleImg: 'assets/icons/profileUser.svg',
            //             title: 'Mental Health',
            //             description: 'Will Meditation Help Me Sleep Better?',
            //             likes: 100,
            //             views: 100,
            //           ),
            //         ),
            //       ),
            //       GestureDetector(
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: MindFullResourceCard(
            //             titleImg: 'assets/icons/profileUser.svg',
            //             title: 'Stress Management',
            //             description: 'Tips to Manage Stress in Daily Life',
            //             likes: 150,
            //             views: 200,
            //           ),
            //         ),
            //       ),
            //       GestureDetector(
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: MindFullResourceCard(
            //             titleImg: 'assets/icons/profileUser.svg',
            //             title: 'Mindfulness Meditation',
            //             description: 'How to Practice Mindfulness Meditation',
            //             likes: 120,
            //             views: 180,
            //           ),
            //         ),
            //       ),
            //       GestureDetector(
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: MindFullResourceCard(
            //             titleImg: 'assets/icons/profileUser.svg',
            //             title: 'Emotional Wellness',
            //             description: 'Understanding and Nurturing Your Emotions',
            //             likes: 90,
            //             views: 150,
            //           ),
            //         ),
            //       ),
            //       GestureDetector(
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: MindFullResourceCard(
            //             titleImg: 'assets/icons/profileUser.svg',
            //             title: 'Self-care Practices',
            //             description:
            //                 'Effective Self-care Tips for Better Well-being',
            //             likes: 110,
            //             views: 170,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            //create a Card Showing Image and Text "Our Resources"
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OurResources(),
                    ));
              },
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    image: DecorationImage(
                      image: AssetImage('images/mindfullhourscard.jpg'),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                        width: 1,
                        style: BorderStyle.solid,
                        color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: Offset(0, 0),
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ]),
                child: Center(
                  child: Text(
                    'Our Resources',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ),
                padding: EdgeInsets.all(20.0),
              ),
            ),
            SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}

class AiTherapistContainer extends StatelessWidget {
  const AiTherapistContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'AI Therapist',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Stack(
              fit: StackFit.loose,
              children: [
                //bg image
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(35.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35.0),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.darken),
                      child: Image.asset(
                        'images/aichatbotbggrayimage.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
                //texts and convo count
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '2541',
                        style: TextStyle(
                          fontSize: 60.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Conversations',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '83 this month',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      // Text(
                      //   'Chat Now',
                      //   style: TextStyle(
                      //     fontSize: 20.0,
                      //     fontWeight: FontWeight.w600,
                      //     color: Colors.white,
                      //   ),
                      // ),
                    ],
                  ),
                ),

                //two buttons
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatBotChatScreen()),
                          );
                        },
                        child: Container(
                          width: 150.0,
                          height: 50.0,
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Center(
                            child: Text(
                              'Chat Now',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFEC7D1C),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatBotChatScreen()),
                          );
                        },
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFEC7D1C),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 30.0,
                              color: Colors.white,
                            ),
                          ),
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

class MindfulTrackerContainer extends StatelessWidget {
  const MindfulTrackerContainer({
    Key? key,
    required this.mindfulTrackerCustomListTile,
  }) : super(key: key);

  final Widget mindfulTrackerCustomListTile; // Adjusted to accept any Widget
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mindful Tracker',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            mindfulTrackerCustomListTile, // Use the customListTile directly
          ],
        ),
      ),
    );
  }
}

class MentalHealthSliderContainer extends StatelessWidget {
  const MentalHealthSliderContainer({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          //create a slider with 3 cards
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16.0),
          child: Column(
              //create a row having text "mental health" and an icon of three dots . make them space between
              children: [
                //text "mental health" and an icon of three dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mental Health',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                //create a card
                ScrollbarTheme(
                  data: ScrollbarThemeData(
                    thumbColor:
                        MaterialStateProperty.all<Color>(Color(0xFFEC7D1C)),
                    // Color of the thumb
                    trackColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    // Color of the track
                    crossAxisMargin: -20,
                    // Margin on the cross axis
                    mainAxisMargin: 10,
                    // Margin on the main axis
                    radius: Radius.circular(8),
                    // Radius of the thumb
                    minThumbLength: 60,
                    thickness: MaterialStateProperty.all<double>(
                        8), // Thickness of the thumb
                  ),
                  child: Scrollbar(
                    thumbVisibility: true, // Show the scrollbar always
                    controller: _scrollController, // Pass the ScrollController

                    child: SizedBox(
                      height: 200, // Adjust height as needed
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        controller:
                            _scrollController, // Pass the ScrollController

                        children: [
                          _buildCard(
                              '🧠 MindFull',
                              '${_userInformation.mindful_hours_score}',
                              Color(0xFF736B66), onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewExercise()),
                            );
                          }),
                          _buildCard(
                              '📃 Articles',
                              '${_userInformation.articles_scores}',
                              Color(0xFF9AB067), onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OurArticle()));
                          }),
                          _buildCard(
                              '😔 Mood',
                              '${_userInformation.mood_score}',
                              Color(0xFFB2B60F), onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DummyContainer(),
                              ),
                            );
                          }),
                          _buildCard(
                              '🔥 Audios',
                              '${_userInformation.audio_score}',
                              Color(0xFF2ACAD9), onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MusicPlay()),
                            );
                          }),

                          _buildCard(
                              '🗣️ Chats',
                              '${_userInformation.chatbot_score}',
                              Color(0xFFC86E6E), onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatBotChatScreen(),
                              ),
                            );
                          }),
                          _buildCard(
                              '🔉 Courses',
                              '${_userInformation.course_score}',
                              Color(0xFF6E6EC8), onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OurCourses(),
                              ),
                            );
                          }),

                          // Add more cards as needed
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
        ));
  }
}

class LandingprofileContainer extends StatelessWidget {
  const LandingprofileContainer({
    super.key,
    required this.formattedDate,
    required this.formattedTime,
    required this.userInformation,
  });

  final String formattedDate;
  final String formattedTime;
  final Map userInformation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xFFEC7D1C),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            children: [
              Row(
                //create date and a notification icon and make them space between
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '📅$formattedDate, $formattedTime',
                    style: TextStyle(
                      fontSize: 20.0,
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
                              // builder: (context) => NotificationPage()),
                              builder: (context) => NotificationPage()),
                        );
                      },
                      icon: Icon(
                        Icons.notifications,
                        size: 24.0,
                        color: Colors.white,
                      ),
                      splashRadius: 24.0, // Adjust the splash radius as needed
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              //create a profile picture and user name text. below that show score:80% and text"happy"
              Row(
                children: [
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(
                            width: 2,
                            style: BorderStyle.solid,
                            color: Colors.lightBlueAccent)),
                    // child: CircleAvatar(
                    //   radius: 30.0,
                    //   child: SvgPicture.asset(
                    //     'assets/icons/profileUser.svg',
                    //     width: 60.0,
                    //   ),
                    // ),
                    child: Obx(
                      () => ProfilePicture(
                        name: _userInformation.userInformation['fullName'] ??
                            "User",
                        role: '',
                        radius: 30,
                        fontsize: 21,
                        tooltip: true,
                        random: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          userInformation['fullName'] ?? "User",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Obx(
                        () => Text(
                          'Freud Score: ${_userInformation.freud_score}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              //create a search bar
              // Container(
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(50.0),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.grey.withOpacity(0.5),
              //           spreadRadius: 0.0,
              //           blurRadius: 40,
              //           offset: Offset(0, 3),
              //         ),
              //       ]),
              //   child: TextField(
              //     decoration: InputDecoration(
              //       filled: true,
              //       fillColor: Colors.white,
              //       contentPadding: EdgeInsets.all(15.0),
              //       hintText: 'Search',
              //       hintStyle: TextStyle(
              //         fontSize: 20.0,
              //         fontWeight: FontWeight.w600,
              //         color: Colors.grey,
              //       ),
              //       suffixIcon: Icon(
              //         Icons.search,
              //         size: 40.0,
              //         color: Colors.grey,
              //       ),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(50.0),
              //         borderSide: BorderSide.none,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final IconData trailingIcon;
  final Color color;
  final Color headingColor;
  final Color subheadingColor;
  final Function()? onPress;

  CustomListTile({
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.trailingIcon,
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
        margin: EdgeInsets.symmetric(vertical: 10.0), // Add margin for spacing
        decoration: BoxDecoration(
          color: Colors.white, // Background color
          borderRadius: BorderRadius.circular(15.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 5, // Blur radius
              offset: Offset(0, 3), // Offset of the shadow
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(15.0),
          // Padding for ListTile content
          leading: Icon(
            leadingIcon,
            size: 40.0,
            color: color,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: headingColor,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: subheadingColor,
            ),
          ),
          trailing: Icon(
            trailingIcon,
            size: 40.0,
            color: color,
          ),
        ),
      ),
    );
  }
}

Widget _buildCard(String title, String value, Color color,
    {Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 160,
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      // Adjust margin as needed
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        children: [
          Container(
            height: 25,
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Center(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 80,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  final double offset;

  CustomFloatingActionButtonLocation(this.offset);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double x = scaffoldGeometry.scaffoldSize.width - 70.0; // Width of FAB
    final double y =
        scaffoldGeometry.scaffoldSize.height - 56.0 - offset; // Height of FAB
    return Offset(x, y);
  }

  @override
  String toString() => 'FloatingActionButtonLocation.bottomRight';
}

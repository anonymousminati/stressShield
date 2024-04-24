import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/customnavbar.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/services/firebase_auth_service.dart';
import 'package:stress_sheild/global_widgets/articleList.dart';
import 'package:stress_sheild/global_widgets/carousel_slider.dart';

UserInformation _userInformation = Get.put(UserInformation());

class DetectorHome extends StatefulWidget {
  final String detectedLabel;

  const DetectorHome({Key? key, required this.detectedLabel}) : super(key: key);

  @override
  State<DetectorHome> createState() => _DetectorHomeState();
}

class _DetectorHomeState extends State<DetectorHome>
    with SingleTickerProviderStateMixin {
  List<dynamic>? songsData;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  String _labelInfo = ''; // Variable to store label information
  bool _isLoading = true; // Variable to track loading state

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();

    // Fetch label information
    // fetchLabelInfo(widget.detectedLabel).then((info) {
    //   setState(() {
    //     _labelInfo = info;
    //     _isLoading = false; // Set loading state to false when data is fetched
    //   });
    // }).catchError((error) {
    //   setState(() {
    //     _isLoading = false; // Set loading state to false if there's an error
    //   });
    // });
    // _fetchSongsData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Future<String> fetchLabelInfo(String label) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('https://en.wikipedia.org/api/rest_v1/page/summary/$label'),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = json.decode(response.body);
  //       String extract = data['extract'] ?? '';
  //       // Limiting to 4-5 lines
  //       if (extract.length > 500) {
  //         extract = extract.substring(0, 500) + '...';
  //       }
  //       return extract;
  //     } else {
  //       throw Exception('Failed to load label information');
  //     }
  //   } catch (e) {
  //     print('Error fetching label information: $e');
  //     return 'Failed to load label information. Please try again later.';
  //   }
  // }

  // Future<void> _refreshPage() async {
  //   setState(() {
  //     _isLoading = true; // Set loading state to true while fetching data
  //   });
  //
  //   // Fetch label information
  //   await fetchLabelInfo(widget.detectedLabel).then((info) {
  //     setState(() {
  //       _labelInfo = info;
  //       _isLoading = false; // Set loading state to false when data is fetched
  //     });
  //   }).catchError((error) {
  //     setState(() {
  //       _isLoading = false; // Set loading state to false if there's an error
  //     });
  //   });
  // }

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
                      _userInformation.mood_score.value += addScore;
                      print('Articles Score: ${_userInformation.mood_score}');
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
    return WillPopScope(
      onWillPop: () async {
        // Navigate to home screen directly when back button is pressed
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavWithAnimations()),
          (Route<dynamic> route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/newbackground.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (_isLoading)
                Center(
                  child: Lottie.asset(
                    'assets/lottie/loading_animation.json',
                    // Replace with your Lottie animation file path
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                )
              else
                RefreshIndicator(
                  onRefresh: () async {},
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 10.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    // Close the camera session and the app

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return _popup();
                                      },
                                    );

                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             BottomNavWithAnimations())); // Pop until the root route
                                  },
                                  icon: Icon(Icons.arrow_back),
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Detector Home',
                                style: TextStyle(
                                  color: Color(0xFF50E4FF),
                                  fontSize: 25,
                                  fontFamily: 'SF Pro',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 36), // Adjust the width as needed
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(height: 10),
                        FadeTransition(
                            opacity: _fadeAnimation,
                            child: CarouselWithEmotionIndicator(
                                detectedLabel: widget.detectedLabel)),
                        SizedBox(height: 30),
                        Image(
                          image: AssetImage('images/line.png'),
                          width: 350,
                        ),
                        SizedBox(height: 20),
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Center(
                            child: Text(
                              'RECOMMENDED ARTICLES',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 15,
                                fontFamily: 'SF Pro',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                            padding: EdgeInsets.all(10),
                            //add border and border-radius
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: ArticleListViewBuilder(),
                            )),
                        SizedBox(height: 20),
                        Image(
                          image: AssetImage('images/line.png'),
                          width: 350,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Inside _showBottomSheet function

  void _showBottomSheet(Map<String, dynamic> song) {
    if (songsData != null) {
      showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(song['name']),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(song['image_url']),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.skip_previous),
                    onPressed: () {
                      // Implement back functionality
                      int? currentIndex = songsData!.indexOf(song);
                      if (currentIndex! > 0) {
                        Map<String, dynamic> previousSong =
                            songsData![currentIndex - 1];
                        print('Playing previous song: ${previousSong['name']}');
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.play_arrow),
                    onPressed: () {
                      // Implement play/pause functionality
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.skip_next),
                    onPressed: () {
                      // Implement next functionality
                      int? currentIndex = songsData!.indexOf(song);
                      if (currentIndex! < songsData!.length - 1) {
                        Map<String, dynamic> nextSong =
                            songsData![currentIndex + 1];
                        print('Playing next song: ${nextSong['name']}');
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}

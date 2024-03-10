import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:stress_sheild/global_widgets/reusable_material_button.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

String videoUrl = "assets/videos/videoplayback.mp4";

class MindfulActivities extends StatefulWidget {
  const MindfulActivities({super.key});

  @override
  State<MindfulActivities> createState() => _MindfulActivitiesState();
}

class _MindfulActivitiesState extends State<MindfulActivities> {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: SafeArea(
          child: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFF35A84E),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //create a icon button with back arrow
                      Container(
                        // padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                            weight: 700,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mindfulness\nActivities',
                              style: TextStyle(
                                fontSize: 36.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Suggested Activities',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF35A84E),
                        ),
                      ),
                    ],
                  ),
                ),

                //create a card with a icon and text.
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SuggestedActivitiesCard(
                        icon: Icons.energy_savings_leaf,
                        color: Colors.brown,
                        title: 'Daily Meditation Routine',
                      ),
                      SuggestedActivitiesCard(
                        icon: Icons.assignment,
                        color: Colors.brown,
                        title: 'Gratefullness Journaling',
                      ),
                      SuggestedActivitiesCard(
                        icon: Icons.repeat,
                        color: Colors.brown,
                        title: 'Affirmation Practice',
                      ),
                      SuggestedActivitiesCard(
                        icon: Icons.air,
                        color: Colors.brown,
                        title: 'Mindful Breathing',
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mindful Resources',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF35A84E),
                        ),
                      ),
                    ],
                  ),
                ),

                //create a card with a mediaPlayer at top and video title and  video description bellow the title.also at bottom make benefit of the video like " reduce stress"
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      //create a video player
                      PlayerWidget(),
                      // YoutubePlayerWidget(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          Text('Reduce Stress'),
                          Text('Improve Health'),
                        ],
                      ),

                      ReusableButton(icon: Icon(Icons.check,size: 24,color: Colors.white,), text: 'Mark As Complete', onPressed: () {


                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}



class YoutubePlayerWidget extends StatefulWidget {
  @override
  _YoutubePlayerWidgetState createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'kdXa4J_lKcY', // Replace with your video ID
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Adjust height as needed
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        onReady: () {
          // You can use the controller to interact with the video once it's ready.
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
class PlayerWidget extends StatefulWidget {
  const PlayerWidget({Key? key}) : super(key: key);

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  bool isVideoInitialized = false;
  String errorDescription = '';

  @override
  void initState() {
    super.initState();

    // Load the video from the assets
    videoPlayerController = VideoPlayerController.asset(
      'assets/videos/videoplayback.mp4',
    );

    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      await videoPlayerController.initialize();
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: true,
      );
      setState(() {
        isVideoInitialized = true;
      });
    } catch (e) {
      setState(() {
        errorDescription = 'Error initializing video: $e';
      });
      // Handle initialization errors (e.g., display error message)
    }
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (errorDescription.isNotEmpty) {
      return Center(child: Text(errorDescription)); // Display error message
    } else if (!isVideoInitialized) {
      return Container(
        height: 200,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5), // Shadow color
                spreadRadius: 2, // Spread radius
                blurRadius: 5, // Blur radius
                offset: Offset(0, 2), // Offset in the x, y directions
              ),
            ],
            color: Colors.grey[200], // Background color
          ),
          child: AspectRatio(
            aspectRatio: videoPlayerController.value.aspectRatio,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Chewie(controller: chewieController)),
          ),
        ),
      );
    }
  }
}

class SuggestedActivitiesCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;

  const SuggestedActivitiesCard({
    Key? key,
    required this.icon,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 200,
        padding: EdgeInsets.all(16.0),
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6.0,
              spreadRadius: 2.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              size: 30.0,
              color: color,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

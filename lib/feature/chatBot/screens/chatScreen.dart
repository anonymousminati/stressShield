import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/customnavbar.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/services/firebase_auth_service.dart';

final UserInformation _userInformation = Get.put(UserInformation());

class ChatBotChatScreen extends StatefulWidget {
  const ChatBotChatScreen({super.key});

  @override
  State<ChatBotChatScreen> createState() => _ChatBotChatScreenState();
}

class _ChatBotChatScreenState extends State<ChatBotChatScreen> {
  ScrollController _chatScrollController = ScrollController();
  TextEditingController _userInput = TextEditingController();

  static const apiKey = "AIzaSyCGFAKeGn3N8r7mkZN3VEqyn7wiVKpI4Qg";

  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  final List<Message> _messages = [];

  @override
  initState() {
    super.initState();

    firstMessage();
  }

  Widget _popup() {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Image.asset('images/popup (3).jpg'),
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
                      _userInformation.chatbot_score.value += addScore;
                      print('chatbot Score: ${_userInformation.chatbot_score}');
                      _userInformation.uploadUserInformation();
                      // Handle 'Mark as Read' button press
                      print('Mark as Read Pressed!');
                      _userInformation.fetchUserInformation();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomNavWithAnimations(),
                          ),
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

  Future<void> firstMessage() async {
    final content = [
      Content.text(
          'act as a friendly , psycyatrict doctor which will chat with user and help them to get rid of their mental health issues. detect the users mood and provide them with the best possible solution to their problem.your name is Dr. Alex. for starting just greet the user and introduce yourself. remember user is Army officers and Police.')
    ];

    final response = await model.generateContent(content);

    setState(() {
      _messages.insert(
          0,
          Message(
              isUser: false,
              message: response.text ?? "",
              date: DateTime.now()));
    });
  }

  Future<void> sendMessage() async {
    final message = _userInput.text;

    setState(() {
      _messages.insert(
          0, Message(isUser: true, message: message, date: DateTime.now()));
    });

    final content = [Content.text(message)];
    final response = await model.generateContent(content);

    setState(() {
      _messages.insert(
          0,
          Message(
              isUser: false,
              message: response.text ?? "",
              date: DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //create a appBar with title and back button
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple, // Transparent app bar
        elevation: 0, // No shadow
        leading: IconButton(
          style: //create round border
              ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
                side: BorderSide(color: Colors.white),
              ),
            ),
          ),
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return _popup();
              },
            );
            // Go back
          },

          color: Colors.white,
          splashRadius: 25,
          highlightColor:
              Colors.white.withOpacity(0.3), // Highlight color when pressed
          iconSize: 30,
        ),
        title: Text(
          // Title
          'Talk with Dr. Alex',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        // Other properties as needed
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.deepPurpleAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: ListView.builder(
                    controller: _chatScrollController,
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return Messages(
                          isUser: message.isUser,
                          message: message.message,
                          date: DateFormat('HH:mm').format(message.date));
                    })),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 15,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _userInput,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Color(0xffffffff)), // Customize border color
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Enter Your Message',
                        labelStyle: TextStyle(
                            color: Colors.white), // Customize label text color
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      padding: EdgeInsets.all(12),
                      iconSize: 30,
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(CircleBorder())),
                      onPressed: () {
                        sendMessage();
                        _userInput.clear();
                      },
                      icon: Icon(Icons.send))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({required this.isUser, required this.message, required this.date});
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;

  const Messages(
      {super.key,
      required this.isUser,
      required this.message,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 15)
          .copyWith(left: isUser ? 100 : 10, right: isUser ? 10 : 100),
      decoration: BoxDecoration(
          color: isUser ? Colors.blueAccent : Colors.grey.shade400,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: isUser ? Radius.circular(10) : Radius.zero,
              topRight: Radius.circular(10),
              bottomRight: isUser ? Radius.zero : Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
                fontSize: 16, color: isUser ? Colors.white : Colors.black),
          ),
          Text(
            date,
            style: TextStyle(
              fontSize: 10,
              color: isUser ? Colors.white : Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/customnavbar.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/services/firebase_auth_service.dart';
//TODO: overflow use singlechildscrollview

UserInformation _userInformation = Get.put(UserInformation());

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  Future<void> _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('feedbacks').add({
          'fullName': _userInformation.fullname.value,
          'uid': _userInformation.uid.value,
          'emailId': _userInformation.email.value,
          'mobileNo': _userInformation.mobileNo.value,
          'title': _titleController.text,
          'feedback': _feedbackController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Feedback submitted successfully!')),
        );
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavWithAnimations(),
            ),
            (route) => false);
        //if form is empty then dont submit else navigate
      } catch (e) {
        print('Error submitting feedback: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to submit feedback. Please try again later.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavWithAnimations(),
                ),
                (route) => false);
          },
        ),
        title: Text('Feedback Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //use lottiefile
                Lottie.asset('assets/lottie/feedback.json'),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: ' TITLE',
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple.shade300),
                    ),
                    labelStyle: const TextStyle(color: Colors.deepPurple),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title for your feedback';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _feedbackController,
                  decoration: InputDecoration(
                    labelText: 'FEEDBACK',
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple.shade300),
                    ),
                    labelStyle: const TextStyle(color: Colors.deepPurple),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your feedback';
                    }
                    return null;
                  },
                  maxLines: 3,
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: _submitFeedback,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade300,
                        border: Border.all(color: Colors.deepPurple.shade300),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        'Submit Feedback',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FeedbackForm(),
    );
  }
}

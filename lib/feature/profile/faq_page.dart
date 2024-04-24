import 'package:flutter/material.dart';
import 'package:stress_sheild/feature/profile/help_page.dart';
// Import the HelpPage

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Text(
                      'FAQs',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              FAQItem(
                  question: 'What is StressShield?',
                  answer:
                      'StressShield is a mobile application designed to help you manage and reduce stress in your daily life through various features and resources.'),
              SizedBox(height: 20.0),
              FAQItem(
                  question: 'How does StressShield work?',
                  answer:
                      'StressShield offers a range of tools and techniques, including meditation exercises, mood tracking, and personalized resources, to help you identify, manage, and alleviate stress.'),
              SizedBox(height: 20.0),
              FAQItem(
                question: 'Is StressShield free to use? ',
                answer:
                    'Yes, StressShield is free to download and use. Some premium features may require in-app purchases.',
              ),
              SizedBox(height: 20.0),
              FAQItem(
                question: 'Is my data secure with StressShield?',
                answer:
                    'Yes, we take your privacy and security seriously. StressShield follows industry best practices to safeguard your personal information. Please refer to our Privacy Policy for more details.',
              ),
              SizedBox(height: 20.0),
              FAQItem(
                question: 'Can I track my progress with StressShield? ',
                answer:
                    'Absolutely! StressShield provides tools like mood tracking and meditation logs to help you monitor your progress over time and see how your stress levels change.',
              ),
              SizedBox(height: 20.0),
              FAQItem(
                question:
                    'Are there any age restrictions for using StressShield?',
                answer:
                    'StressShield is intended for users aged 18 and above. However, younger users may also benefit from the app under adult supervision.',
              ),
              SizedBox(height: 20.0),
              FAQItem(
                  question: 'Can I use StressShield offline?',
                  answer:
                      'Some features of StressShield may require an internet connection, but many functionalities, such as mood tracking and meditation exercises, can be accessed offline once downloaded.'),
              SizedBox(height: 20.0),
              FAQItem(
                  question: 'How often should I use StressShield?',
                  answer:
                      'You can use StressShield as often as you like! Incorporate it into your daily routine or use it whenever you feel stressed and need some support.'),
              SizedBox(height: 20.0),
              FAQItem(
                  question: 'Can I customize StressShield to fit my needs?',
                  answer:
                      'Yes, StressShield offers customizable features like personalized meditation sessions and mood tracking settings to tailor the app to your specific preferences and needs.'),
              SizedBox(height: 20.0),
              FAQItem(
                  question: 'How can I provide feedback or suggestions?',
                  answer:
                      'We welcome your feedback and suggestions! You can contact us through the app or visit our website to share your thoughts and ideas. Your input helps us improve StressShield for all users.'),
              SizedBox(height: 30.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HelpPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo, // Change button color
                    padding: EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 12.0), // Add padding
                  ),
                  child: Text(
                    'Need more help?',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Change text color
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0, // Increase font size
          color: Colors.black, // Change text color
        ),
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            answer,
            style: TextStyle(
                fontSize: 16.0, color: Colors.black87), // Change text color
          ),
        ),
      ],
    );
  }
}

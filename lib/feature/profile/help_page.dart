import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HelpItem(
                question: 'What are the basic features of StressShield?',
                answer:
                    'StressShield offers features like mood tracking, meditation sessions, mindfulness resources, and more to help you manage stress effectively.'),
            SizedBox(height: 20.0),
            HelpItem(
              question:
                  'What should I do if I encounter technical issues with StressShield?',
              answer:
                  'Check your internet connection, ensure that your device meets the app\'s system requirements, and try restarting the app. If the issue persists, contact our support team for assistance.',
            ),
            SizedBox(height: 20.0),
            HelpItem(
                question:
                    'How can I resolve common errors or problems with the app?',
                answer:
                    'Refer to the app\'s troubleshooting guide or knowledge base for solutions to common issues. You can also search for answers in the app\'s community forums or contact support for help.'),
            SizedBox(height: 20.0),
            HelpItem(
              question:
                  'Where can I find the rules and guidelines for using StressShield responsibly?',
              answer:
                  'Refer to the Terms of Service and Community Guidelines sections of the app for rules and guidelines on using StressShield responsibly and ethically.',
            ),
            SizedBox(height: 20.0),
            HelpItem(
              question:
                  'How can I get in touch with the support team for assistance?',
              answer:
                  'You can contact our support team via email, phone, or live chat during business hours. Visit the "Contact Us" section of the app for more information.',
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

class HelpItem extends StatelessWidget {
  final String question;
  final String answer;

  const HelpItem({
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
        ),
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            answer,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }
}

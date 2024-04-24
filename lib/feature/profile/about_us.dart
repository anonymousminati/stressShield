import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //add center aligned image
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.asset('images/stressShieldLogo.jpg',
                    height: 200.0, width: 200.0),
              ),
            ),
            Text(
              'Our Story',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Stress Shield was born out of a shared passion for mental health and a desire to make a meaningful difference in people\'s lives. We recognized the growing need for accessible and effective mental health support, especially in today\'s fast-paced and stressful world. They envisioned a solution that would harness the power of technology to provide personalized and proactive mental health care to individuals everywhere.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'With motto "श्रेयो भूयाएव मनुष्यमेति ।", our mission is simple yet profound: to empower individuals to take control of their mental well-being and lead healthier, happier lives. We believe that everyone deserves access to high-quality mental health care, and we are committed to breaking down barriers and stigma surrounding mental illness.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'What Sets Us Apart',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Unlike traditional mental health resources, Stress Shield offers a unique blend of cutting-edge technology and compassionate support. Our app combines the latest advancements in artificial intelligence and machine learning with evidence-based therapeutic techniques to deliver personalized, effective, and accessible mental health care to our users.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Our Values',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '1. Empathy: We approach every aspect of our work with empathy and understanding, recognizing the challenges individuals face when dealing with mental health issues.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '2. Innovation: We are committed to pushing the boundaries of what\'s possible in mental health care through continuous innovation and improvement.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '3. Accessibility: We believe that mental health care should be accessible to all, regardless of location, background, or financial status.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '4. Privacy: We take the privacy and security of our users\' data seriously and adhere to strict protocols to ensure confidentiality and trust.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Our Team',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            // Cards for team members
            TeamMemberCard(
              name: 'Tiya Jagtap',
              imageUrl: 'images/iasTiyaJagtap.jpg',
              role: 'Co-Founder and Devloper',
            ),
            TeamMemberCard(
              name: 'Sakshi Jagtap',
              imageUrl: 'images/sakshiJagtap.jpg',
              role: 'Researcher and Developer',
            ),
            TeamMemberCard(
              name: 'Sakshi Hule',
              imageUrl: 'images/SakshiHule.jpg',
              role: 'Researcher and Developer',
            ),

            SizedBox(height: 20.0),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Have questions or want to get involved? Reach out to us at contact@policestressmanage.org',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

class TeamMemberCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String role;

  const TeamMemberCard({
    required this.name,
    required this.imageUrl,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      showDuration: Duration(seconds: 2),
      message: role,
      child: Card(
        elevation: 4.0,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: AssetImage(imageUrl),
            ),
            title: Text(name, style: TextStyle(fontSize: 18.0)),
          ),
        ),
      ),
    );
  }
}

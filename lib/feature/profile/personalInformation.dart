import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stress_sheild/feature/profile/updateUserInformation.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _userInfoFuture;

  @override
  void initState() {
    super.initState();
    // Fetch user information when the widget initializes
    _userInfoFuture = _fetchUserInfo();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchUserInfo() async {
    final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    final userDocument = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserUid)
        .get();
    return userDocument;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: _userInfoFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final userInfo = snapshot.data!.data();
              final dateOfBirth =
                  (userInfo?['dateOfBirth'] as Timestamp?)?.toDate();
              final formattedDateOfBirth =
                  DateFormat('MMMM dd, yyyy').format(dateOfBirth!);
              return Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff538634),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () {
// Navigate back to previous screen
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Personal Information',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        buildInfoItem(
                          title: 'Date of Birth',
                          value: ' $formattedDateOfBirth',
                          onTap: () {
// Show date picker to edit Date of Birth
                          },
                        ),
                        SizedBox(height: 20),
                        buildInfoItem(
                          title: 'Gender',
                          value: '${userInfo?['gender']}',
                          onTap: () {
// Show gender selection dropdown to edit Gender
                          },
                        ),
                        SizedBox(height: 20),
                        buildInfoItem(
                          title: 'Location',
                          value: '${userInfo?['location']}',
                          onTap: () {
// Show gender selection dropdown to edit Gender
                          },
                        ),
                        SizedBox(height: 20),
                        buildInfoItem(
                          title: 'Weight',
                          value: '${userInfo?['weight']}',
                          onTap: () {
// Show text input field to edit Weight
                          },
                        ),
                        SizedBox(height: 20),
                        buildInfoItem(
                          title: 'Mobile Number',
                          value: '${userInfo?['mobileNo']}',
                          onTap: () {
// Show text input field to edit Mobile Number
                          },
                        ),
                        SizedBox(height: 20),
                        buildInfoItem(
                          title: 'Government ID',
                          value: '${userInfo?['governmentId']}',
                          onTap: () {
// Show text input field to edit Government ID
                          },
                        ),
                        SizedBox(height: 20),
                        //create a button which will redirect to page UserInfoPage()
                        ElevatedButton(
                          onPressed: () {
                            print("userid: ${userInfo?['uid']}");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateUserInfoPage(),
                                ));
                          },
                          child: Text('Edit User Information'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildInfoItem(
      {required String title,
      required String value,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4F3422),
                ),
              ),
              Row(
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff4F3422),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 24.0,
                    color: Color(0xff4F3422),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

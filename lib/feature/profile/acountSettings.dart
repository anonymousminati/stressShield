import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/services/firebase_auth_service.dart';

class AccountSettings extends StatefulWidget {
  AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  final UserInformation _userInformation = Get.put(UserInformation());
  String? username;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//fetch "fullName" from the firebase collection "users" with document current uid
//   FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
//     setState(() {
//       username = value['fullName'];
//     });
//
//   });

    username = _userInformation.userInformation['fullName'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: RefreshIndicator(
      onRefresh: () async {
        await _userInformation.fetchUserInformation();
      },
      child: Scaffold(
          body: Stack(children: [
        Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CircleAvatar(
                //   maxRadius: 65,
                //   backgroundImage: AssetImage("images/profileFace.jpg"),
                // ),
                Obx(
                  () => ProfilePicture(
                    name:
                        _userInformation.userInformation['fullName'] ?? "User",
                    role: '',
                    radius: 31,
                    fontsize: 21,
                    tooltip: true,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => Text(
                      _userInformation.userInformation['fullName'] ?? "User",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 26),
                    ))
              ],
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Expanded(
                  child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Generat Settings",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xff4F3422),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "notification");
                    },
                    child: Card(
                      margin: EdgeInsets.only(left: 35, right: 35, bottom: 10),
                      color: Colors.white70,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        leading: Icon(
                          Icons.notifications,
                          color: Colors.black54,
                        ),
                        title: Text(
                          'Notifications',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "personalInformation");
                    },
                    child: Card(
                      margin: EdgeInsets.only(left: 35, right: 35, bottom: 10),
                      color: Colors.white70,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          color: Colors.black54,
                        ),
                        title: Text(
                          'Personal Information',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: Card(
                      margin: EdgeInsets.only(left: 35, right: 35, bottom: 10),
                      color: Colors.white70,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        leading: Icon(
                          Icons.feedback_sharp,
                          color: Colors.black54,
                        ),
                        title: Text(
                          'Submit Feedback',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Security and Privacy",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xff4F3422),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: Card(
                      margin: EdgeInsets.only(left: 35, right: 35, bottom: 10),
                      color: Colors.white70,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        leading: Icon(
                          Icons.privacy_tip_sharp,
                          color: Colors.black54,
                        ),
                        title: Text(
                          'Privacy',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: Card(
                      color: Colors.white70,
                      margin: EdgeInsets.only(left: 35, right: 35, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        leading: Icon(
                          Icons.history,
                          color: Colors.black54,
                        ),
                        title: Text(
                          'Purchase History',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: Card(
                      color: Colors.white70,
                      margin: EdgeInsets.only(left: 35, right: 35, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        leading:
                            Icon(Icons.help_outline, color: Colors.black54),
                        title: Text(
                          'Help & Support',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: Card(
                      color: Colors.white70,
                      margin: EdgeInsets.only(left: 35, right: 35, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        leading: Icon(
                          Icons.privacy_tip_sharp,
                          color: Colors.black54,
                        ),
                        title: Text(
                          'Settings',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_outlined),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: Card(
                      color: Colors.white70,
                      margin: EdgeInsets.only(left: 35, right: 35, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        leading: Icon(
                          Icons.add_reaction_sharp,
                          color: Colors.black54,
                        ),
                        title: Text(
                          'Invite a Friend',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //create a devider with horizontal line
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Divider(
                      color: Color(0xb34f3422),
                      thickness: 1,
                    ),
                  ),
                  GestureDetector(
                    //onTap logout delete the session and navigate to login page , session is of firebase
                    onTap: () {
                      FirebaseAuthService().signOut().then((value) =>
                          Navigator.pushNamedAndRemoveUntil(
                              context, "login", (route) => false));
                    },

                    child: Card(
                      color: Colors.white70,
                      margin: EdgeInsets.only(left: 35, right: 35, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Colors.black54,
                        ),
                        title: Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_outlined),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              )),
            ),
            SizedBox(
              height: 80,
            )
          ],
        ),
      ])),
    ));
  }
}

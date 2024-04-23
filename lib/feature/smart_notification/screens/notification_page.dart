import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/customnavbar.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/services/firebase_auth_service.dart';

UserInformation _userInformation = Get.put(UserInformation());

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, String>> notifications = [];
  late RemoteMessage message;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchAndUploadNotifications();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   var fetchedNotifications =  fetchNotifications();
  //   setState(() {
  //     notifications = fetchedNotifications as List<Map<String, String>>;
  //   });  }
  //

  Future<void> fetchAndUploadNotifications() async {
    try {
      message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
      await uploadNotification(
        message.notification?.title ?? '',
        message.notification?.body ?? '',
        message.notification?.android?.imageUrl ?? '',
      );
      final fetchedNotifications = await fetchNotifications();
      setState(() {
        notifications = fetchedNotifications;
      });
    } catch (error) {
      print("Failed to fetch and upload notifications: $error");
    }
  }

  Future<void> uploadNotification(
      String title, String subtitle, String imgUrl) async {
    try {
      CollectionReference<Map<String, dynamic>> notificationCollection =
          FirebaseFirestore.instance.collection('notifications');

      // Get the reference to the 'notificationDoc' document
      DocumentReference<Map<String, dynamic>> docRef =
          notificationCollection.doc('notificationDoc');

      // Get the current list of notifications from Firestore
      DocumentSnapshot<Map<String, dynamic>> docSnapshot = await docRef.get();

      // Extract the notifications list from the document snapshot
      List<dynamic>? currentNotificationsData =
          docSnapshot.data()?['notifications'];

      // Convert the dynamic list to the expected type
      List<Map<String, dynamic>> currentNotifications =
          List<Map<String, dynamic>>.from(currentNotificationsData ?? []);

      // Add the new notification to the list
      currentNotifications.add({
        'title': title,
        'subtitle': subtitle,
        'img_url': imgUrl,
      });

      // Update the 'notifications' array field in Firestore
      await docRef.set({'notifications': currentNotifications});

      print("Notification Added to Firestore");
    } catch (error) {
      print("Failed to add notification to Firestore: $error");
    }
  }

  Future<List<Map<String, String>>> fetchNotifications() async {
    try {
      CollectionReference<Map<String, dynamic>> notificationCollection =
          FirebaseFirestore.instance.collection('notifications');

      // Get the reference to the 'notificationDoc' document
      DocumentReference<Map<String, dynamic>> docRef =
          notificationCollection.doc('notificationDoc');

      // Get the document snapshot
      DocumentSnapshot<Map<String, dynamic>> docSnapshot = await docRef.get();

      // Get the notifications field from the document snapshot
      List<dynamic>? notificationsData = docSnapshot.data()?['notifications'];

      // Convert the dynamic list to the expected type
      List<Map<String, String>> notifications =
          (notificationsData ?? []).map<Map<String, String>>((dynamic data) {
        return Map<String, String>.from(data);
      }).toList();

      return notifications;
    } catch (error) {
      print("Failed to fetch notifications: $error");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _userInformation.fetchUserInformation();
        var fetchedNotifications = await fetchNotifications();
        setState(() {
          notifications = fetchedNotifications;
        });
      },
      child: Scaffold(
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
          title: Text('Notifications'),
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Notification",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFC89E),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "${notifications.length}+",
                        style: TextStyle(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Obx(
                      () => CircleAvatar(
                        radius: 40,
                        child: ProfilePicture(
                          name: _userInformation.fullname.value.toString(),
                          radius: 40,
                          fontsize: 24,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: FutureBuilder<List<Map<String, String>>>(
                  future: fetchNotifications(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error fetching notifications'),
                      );
                    } else {
                      List<Map<String, String>> notifications = snapshot.data!;
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          final notification = notifications[index];
                          return Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    NetworkImage(notification['img_url']!),
                              ),
                              title: Text(
                                notification['title']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color(0xFF4F3422),
                                ),
                              ),
                              subtitle: Text(
                                notification['subtitle']!,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 10);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ListTile(
// leading: CircleAvatar(
// backgroundImage: NetworkImage(notification['img_url']!),
// ),
// title: Text(notification['title']!),
// subtitle: Text(notification['subtitle']!),

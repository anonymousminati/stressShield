
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stress_sheild/feature/communityChat/helper/helper_function.dart';
import 'package:stress_sheild/feature/communityChat/pages/profile_page.dart';
import 'package:stress_sheild/feature/communityChat/pages/search_page.dart';
import 'package:stress_sheild/feature/communityChat/services/database_service.dart';
import 'package:stress_sheild/feature/communityChat/widgets/group_tile.dart';
import 'package:stress_sheild/feature/communityChat/widgets/widgets.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/screens/login_screen.dart';
import '../services/auth_service.dart';

class CommunityChatLandingPage extends StatefulWidget {
  const CommunityChatLandingPage({Key? key}) : super(key: key);

  @override
  State<CommunityChatLandingPage> createState() => _CommunityChatLandingPageState();
}

class _CommunityChatLandingPageState extends State<CommunityChatLandingPage> {
  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  Stream<QuerySnapshot<Object?>>? groups;
  bool _isLoading = false;
  String groupName = "";

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  // String manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    await HelperFunction.getUserNameFromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
    await HelperFunction.getUserEmailFromSF().then((val) => {
      setState(() {
        email = val!;
      })
    });

    // Ensure `DataBaseService` is properly initialized
    groups = DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid).getUserGroups() as Stream<QuerySnapshot<Object?>>;

    // Optional: Manually refresh stream for debugging (comment out later)
    // groups?.listen((event) => event.ref.get());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            IconButton(
                onPressed:(){ nextScreen(context, const SearchPage());},
                icon: const Icon(Icons.search,  ))
          ],
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("Groups", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),),
        ),


      body: groupList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          popUpDialog(context);
        },
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white, size: 30,),
      ),

    );
  }

  // popUpDialog(BuildContext context){
  //   showDialog(barrierDismissible: false, context: context, builder: (context){
  //     return StatefulBuilder(
  //       builder: ((context, setState){
  //       return AlertDialog(
  //         title: const Text("Create a group",textAlign: TextAlign.left,),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             _isLoading == true ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),)
  //                 : TextField(
  //               onChanged: (val){
  //                 setState(() {
  //                   groupName = val;
  //                 });
  //               },
  //               style: const TextStyle(color: Colors.black),
  //               decoration: InputDecoration(
  //                 enabledBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(color: Theme.of(context).primaryColor),
  //                   borderRadius: BorderRadius.circular(15),
  //                 ),
  //                 focusedBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(color: Theme.of(context).primaryColor),
  //                   borderRadius: BorderRadius.circular(15),
  //                 ),
  //                 errorBorder: OutlineInputBorder(
  //                   borderSide: const BorderSide(color: Colors.red),
  //                   borderRadius: BorderRadius.circular(15),
  //                 )
  //               ),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           ElevatedButton(onPressed: (){
  //             Navigator.of(context).pop();
  //           },
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: Theme.of(context).primaryColor,
  //           ),
  //             child: const Text("CANCEL"),
  //           ),
  //           ElevatedButton(onPressed: () async {
  //             if(groupName != ""){
  //               setState(() {
  //                 _isLoading = true;
  //               });
  //               DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid).createGroup(userName, FirebaseAuth.instance.currentUser!.uid, groupName).whenComplete(() {
  //                 setState(() {
  //                   _isLoading = false;
  //                 });
  //                 Navigator.of(context).pop();
  //                 showSnakbar(context, Colors.green, "Group created successfully.😍");
  //               });
  //             }
  //           },
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Theme.of(context).primaryColor,
  //             ),
  //             child: const Text("CREATE"),
  //           )
  //
  //         ],
  //       );
  //       })
  //     );
  //   });
  // }
  popUpDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
      return StatefulBuilder(
          builder: ((context, setState) {
        return AlertDialog(
          title: const Text("Create a group", textAlign: TextAlign.left),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
          _isLoading == true
          ? Center(
          child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
        ),
    )
        : TextField(
    onChanged: (val) {
    setState(() {
    groupName = val;
    });
    },
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Theme.of(context).primaryColor),
    borderRadius: BorderRadius.circular(15),
    ),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(15),
    ),
      hintText: "Group Name",
      hintStyle: const TextStyle(color: Colors.grey),
      fillColor: Colors.white,
    ),
          ),
              ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => createGroup(context, groupName),
              child: const Text("Create"),
            ),
          ],
        );
          }),
      );
        });
  }


  // groupList(){
  //   return StreamBuilder(stream: groups,
  //   builder: (context, snapshot){
  //     // make some check
  //     if(snapshot.hasData){
  //       print("snapshot.data?.docs:${snapshot.data?.docs}");
  //       if(snapshot.data?.docs != null){
  //         if(snapshot.data?.docs['groups'].length != 0){
  //           return ListView.builder(
  //             itemCount: snapshot.data?.docs['groups'].length,
  //             itemBuilder: (context,index){
  //               int reveseIndex = snapshot.data?.docs['groups'].length - index - 1;
  //               return GroupTile(
  //                   groupName: getName(snapshot.data?.docs['groups'][reveseIndex]), groupId: getId(snapshot.data?.docs['groups'][reveseIndex]), userName: snapshot.data?.docs['fullName']);
  //             },
  //           );
  //         }else{
  //           return noGroupWidget();
  //         }
  //       }
  //       else{
  //         return noGroupWidget();
  //       }
  //     }
  //     else{
  //       return Center(
  //         child: CircularProgressIndicator(
  //           color: Theme.of(context).primaryColor,
  //
  //         ),
  //       );}
  //   },
  //   );
  // }

  // groupList() {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: groups,
  //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //       // Check for errors and display error message
  //       if (snapshot.hasError) {
  //         return Text('Error: ${snapshot.error}');
  //       }
  //
  //       // Display loading indicator while waiting for data
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Center(
  //           child: CircularProgressIndicator(
  //             color: Theme.of(context).primaryColor,
  //           ),
  //         );
  //       }
  //
  //       // Extract data from the snapshot
  //       final List<QueryDocumentSnapshot<Object?>>? documents = snapshot.data?.docs;
  //
  //       // Handle empty data scenario
  //       if (documents!.isEmpty) {
  //         return noGroupWidget();
  //       }
  //
  //       // Build ListView with group data
  //       return ListView.builder(
  //         itemCount: documents.length,
  //         itemBuilder: (context, index) {
  //           final doc = documents[index];
  //           final data = doc.data() as Map<String, dynamic>; // Cast data to Map
  //
  //           // Handle potential null values for 'groups' field
  //           if (data.containsKey('groups')) {
  //             final groupName = getName(data['groups']);
  //             final groupId = getId(data['groups']);
  //             final userName = data['fullName'];
  //
  //             return GroupTile(
  //                 groupName: groupName,
  //                 groupId: groupId,
  //                 userName: userName);
  //           } else {
  //             // Handle cases where 'groups' field is missing
  //             return Text('Group data unavailable'); // Or display a custom message
  //           }
  //         },
  //       );
  //     },
  //   );
  // }
  // groupList() {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: groups,
  //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //       // Check for errors and display error message
  //       if (snapshot.hasError) {
  //         return Text('Error: ${snapshot.error}');
  //       }
  //
  //       // Display loading indicator while waiting for data
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Center(
  //           child: CircularProgressIndicator(
  //             color: Theme.of(context).primaryColor,
  //           ),
  //         );
  //       }
  //
  //       // Extract data from the snapshot
  //       final List<QueryDocumentSnapshot<Object?>>? documents = snapshot.data?.docs;
  //
  //       // Handle empty data scenario
  //       if (documents!.isEmpty) {
  //         return noGroupWidget();
  //       }
  //
  //       // Filter groups where the current user is a member
  //       final userUid = FirebaseAuth.instance.currentUser!.uid;
  //       final userGroups = documents.where((doc) {
  //         final data = doc.data() as Map<String, dynamic>;
  //         final members = data['members'] as List?;
  //         return members != null && members.contains(userUid);
  //       }).toList();
  //
  //       // Build ListView with group data
  //       return ListView.builder(
  //         itemCount: userGroups.length,
  //         itemBuilder: (context, index) {
  //           final doc = userGroups[index];
  //           final data = doc.data() as Map<String, dynamic>; // Cast data to Map
  //
  //           final groupName = data['groupName'] ?? ''; // Adjust as per your Firestore schema
  //           final groupId = doc.id; // Use document ID as group ID
  //           final userName = data['fullName'] ?? ''; // Adjust as per your Firestore schema
  //
  //           return GroupTile(
  //             groupName: groupName,
  //             groupId: groupId,
  //             userName: userName,
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  // groupList() {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: groups,
  //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Center(
  //           child: CircularProgressIndicator(
  //             color: Theme.of(context).primaryColor,
  //           ),
  //         );
  //       } else if (snapshot.hasError) {
  //         return Text('Error: ${snapshot.error}');
  //       } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
  //         return noGroupWidget();
  //       } else {
  //         final List<QueryDocumentSnapshot<Object?>>? documents = snapshot.data!.docs;
  //         final userUid = FirebaseAuth.instance.currentUser!.uid;
  //         final userGroups = documents!.where((doc) {
  //           final data = doc.data() as Map<String, dynamic>;
  //           final members = data['members'] as List?;
  //           return members != null && members.contains(userUid);
  //         }).toList();
  //
  //         return ListView.builder(
  //           itemCount: userGroups.length,
  //           itemBuilder: (context, index) {
  //             final doc = userGroups[index];
  //             final data = doc.data() as Map<String, dynamic>;
  //
  //             final groupName = data['groupName'] ?? '';
  //             final groupId = doc.id;
  //             final userName = data['fullName'] ?? '';
  //
  //             return GroupTile(
  //               groupName: groupName,
  //               groupId: groupId,
  //               userName: userName,
  //             );
  //           },
  //         );
  //       }
  //     },
  //   );
  // }

  Future<void> createGroup(BuildContext context, String groupName) async {
    if (groupName.isNotEmpty) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      // Create a new group document in Firestore
      String groupId = await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
          .createGroup(groupName);

      // Add current user to the group's member list
      await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
          .addUserToGroup(groupId, FirebaseAuth.instance.currentUser!.uid);

      setState(() {
        _isLoading = false; // Hide loading indicator
      });
      Navigator.pop(context); // Close dialog

      // Optional: Refresh stream manually (consider best practice)
      // groups?.listen((event) => event.ref.get());
    } else {
      print("Please enter a group name");
    }
  }

  Widget groupList() {
    return StreamBuilder<QuerySnapshot<Object?>>(
      stream: groups,
      builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          print('No groups found in Firestore snapshot.');
          return noGroupWidget();
        } else {
          final List<QueryDocumentSnapshot<Object?>> documents = snapshot.data!.docs;

          // Optional: Filter groups based on membership (if needed)
          final userUid = FirebaseAuth.instance.currentUser!.uid;
          final userGroups = documents.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final members = data['members'] as List?;
            return members != null && members.contains(userUid);
          }).toList();

          return ListView.builder(
            itemCount: userGroups.length, // Use filtered list length
            itemBuilder: (context, index) {
              final doc = userGroups[index];
              final data = doc.data() as Map<String, dynamic>;

              final groupName = data['groupName'] ?? ''; // Handle potential null value
              final groupId = doc.id;
              final userName = data['fullName'] ?? ''; // Handle potential null value (if applicable)

              return GroupTile(
                groupName: groupName,
                groupId: groupId,
                userName: userName,
              );
            },
          );
        }
      },
    );
  }


  noGroupWidget(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              popUpDialog(context);
            },
              child: Icon(Icons.add_circle, color: Colors.grey[700], size: 75,)),
          const SizedBox(height: 20,),
          const Text("You've not joined any gruops, tap on the add icon to create a group otherwise search from top search button"
          , textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String? uid;

  DataBaseService({this.uid});

  // reference for our collecitons
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  // saving the userdata
  Future savingUserdata(String fullname, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullname,
      "emailId": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("emailId", isEqualTo: email).get();
    return snapshot;
  }

  // get user groups
  Stream<QuerySnapshot<Object?>> getUserGroups() {
    return FirebaseFirestore.instance
        .collection('groups')
        .where('members', arrayContains: '$uid')
        .snapshots();
  }

  // creating a group
  // Future createGroup(String userName, String id, String groupName) async {
  //   DocumentReference groupDocumentReference = await groupCollection.add({
  //     "groupName": groupName,
  //     "groupIcon": "",
  //     "admin": "${id}_$userName",
  //     "members": [],
  //     "groupId": "",
  //     "recentMessage": "",
  //     "recentMessageSender": "",
  //   });
  //   await groupDocumentReference.update({
  //     "members":FieldValue.arrayUnion(["${uid}_$userName"]),
  //     "groupId": groupDocumentReference.id,
  //   });
  //   DocumentReference userDocumentRefence = userCollection.doc(uid);
  //   // removed await here check once
  //   return await userDocumentRefence.update({
  //     "groups":FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
  //   });
  // }

  Future<void> addUserToGroup(String groupId, String userId) async {
    try {
      // Get the group document reference
      DocumentReference groupDocRef = groupCollection.doc(groupId);

      // Update the 'members' array field in the group document
      await groupDocRef.update({
        "members": FieldValue.arrayUnion(["$userId"])
      });

      // Update the user's 'groups' array field
      DocumentReference userDocRef = userCollection.doc(userId);
      await userDocRef.update({
        "groups": FieldValue.arrayUnion(["$groupId"])
      });
    } catch (e) {
      print("Error adding user to group: $e");
      // Handle any errors here
    }
  }

  Future createGroup(String groupName) async {
    final CollectionReference groupsCollection =
        FirebaseFirestore.instance.collection('groups');

    final docRef = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${uid}_$groupName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
    await docRef.update({
      "members": FieldValue.arrayUnion(["${uid}_$groupName"]),
      "groupId": docRef.id,
    });
    DocumentReference userDocumentRefence = userCollection.doc(uid);
    // removed await here check once
    return await userDocumentRefence.update({
      "groups": FieldValue.arrayUnion(["${docRef.id}_$groupName"])
    });
  }

  //getting the chats
  getChats(String groupId) {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  Future getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  //get members
  getGroupMembers(groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  // search
  serachByName(String groupName) {
    return groupCollection.where("groupName", isEqualTo: groupName).get();
  }

  // return booliean to know present or not
  Future<bool> isUserJoined(
      String groupName, String groupId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
      return true;
    } else {
      return false;
    }
  }

  // toggling the group join/wait
  Future toggleGroupJoin(
      String groupId, String userName, String groupName) async {
    //doc
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];
    //if group has user then remove them or rejoin them
    if (groups.contains("${groupId}_$groupName")) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    } else {
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }
  }

  // send message
  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    groupCollection.doc(groupId).collection("messages").add(chatMessageData);
    groupCollection.doc(groupId).update({
      "recentMessage": chatMessageData['message'],
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
    });
  }
}

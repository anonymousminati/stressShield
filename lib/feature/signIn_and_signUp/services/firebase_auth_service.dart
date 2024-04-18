import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';


class UserInformation extends GetxController {
  var userInformation = {}.obs; // use .obs to make it observable
  var fullname = ''.obs;
  var email = ''.obs;
  var uid = ''.obs;
  var gender = ''.obs;
  var dateOfBirth = DateTime.timestamp().obs;
  var location = ''.obs;
  var weight = 0.0.obs;
  var governmentId = ''.obs;
  var mobileNo = ''.obs;
  var meditaion_score = 0.obs;//meditation
  var mindfulness_score = 0.obs;//mindfulness minute
  var mood_label= 'neutral'.obs;//mood tracker mood label from mood detector
  var stress_score = 0.obs;//stress score
  var community_score = 0.obs;//community score and mindfullness are same
  var trending_song = 'Relaxation Guidline'.obs;// show one song randomly from trending songs
  var trending_video = 'Relaxation Guidline'.obs;// show one video randomly from trending videos
  var mindful_hours_score = 0.obs;//mindful hours card score
  var mood_score = 0.obs;//mood card score
  var audio_score = 0.obs;//stress card score
  var chatbot_score = 0.obs;//chatbot card score
  var articles_scores = 0.obs;//articles card score
  var course_score  = 0.obs;//course card score
  var freud_score = 0.obs;//freud card score


  @override
  void onInit() {
    super.onInit();
    fetchUserInformation();
  }

  //create a function to upload user information to firestore
Future<void> uploadUserInformation() async {
    try {
      userInformation['scores'] = {
        'mindful_hours_score': mindful_hours_score.value,
        'mood_score': mood_score.value,
        'audio_score': audio_score.value,
        'chatbot_score': chatbot_score.value,
        'articles_scores': articles_scores.value,
        'course_score': course_score.value,
        'total_score': freud_score.value,

      };

      userInformation['fullname'] = fullname.value;
      userInformation['email'] = email.value;
      userInformation['gender'] = gender.value;
      userInformation['dateOfBirth'] = dateOfBirth.value;
      userInformation['location'] = location.value;
      userInformation['weight'] = weight.value;
      userInformation['governmentId'] = governmentId.value;
      userInformation['mobileNo'] = mobileNo.value;


      // Upload user information to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(userInformation.toJson()).then((value) => print('uploaded'));
    } catch (e) {
      print('Error uploading user information: $e');
      // Handle error here
    }
  }


  Future<void> fetchUserInformation() async {
    try {
      // Fetch user information from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      // Convert userDoc to Map and assign to userInformation
      userInformation.value =await (userDoc.data() as Map<String, dynamic>?) ?? {};
      print('User Information: $userInformation' );
      mindful_hours_score.value = await userInformation['scores']['mindful_hours_score'];
      mood_score.value = await userInformation['scores']['mood_score'];
      audio_score.value = await userInformation['scores']['audio_score'];
      chatbot_score.value = await userInformation['scores']['chatbot_score'];
      articles_scores.value = await userInformation['scores']['articles_scores'];
      freud_score.value = await userInformation['scores']['total_score'];
      course_score.value = await userInformation['scores']['course_score'];


      print('User Information: $userInformation' );
    } catch (e) {
      print('Error fetching user information: $e');
      // Handle error here
    }
  }


}


class FirebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();



  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    final UserCredential authResult =
        await auth.signInWithCredential(credential);
    final User? user = authResult.user;
    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final User? currentUser = auth.currentUser;
      assert(user.uid == currentUser!.uid);
      print('signInWithGoogle succeeded: $user');
      return user;
    }
    return null;
  }

  // create a function which will fetch user information from firebase with collection "users" and document with current user uid
  Future<Map<String, dynamic>> fetchUserInformation() async {
    final User? user = auth.currentUser;
    final DocumentSnapshot<Map<String, dynamic>> userInformation = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    return userInformation.data()!;
  }


  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    print("User Signed Out");
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return null;
      }
    }
    return null;
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return null;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> updatePassword(String password) async {
    await auth.currentUser!.updatePassword(password);
  }

  Future<void> updateEmail(String email) async {
    await auth.currentUser!.updateEmail(email);
  }

  Future<void> updateDisplayName(String displayName) async {
    await auth.currentUser!.updateDisplayName(displayName);
  }

  Future<void> updatePhotoURL(String photoURL) async {
    await auth.currentUser!.updatePhotoURL(photoURL);
  }

  Future<void> sendEmailVerification() async {
    await auth.currentUser!.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    final User? user = auth.currentUser;
    return user!.emailVerified;
  }

  Future<void> reloadUser() async {
    await auth.currentUser!.reload();
  }

  Future<User?> getCurrentUser() async {
    final User? user = auth.currentUser;
    return user;
  }

  Future<String?> getCurrentUserEmail() async {
    final User? user = auth.currentUser;
    return user!.email;
  }

  Future<String?> getCurrentUserUID() async {
    final User? user = auth.currentUser;
    return user!.uid;
  }

  Future<String?> getCurrentUserDisplayName() async {
    final User? user = auth.currentUser;
    return user!.displayName;
  }

  Future<String?> getCurrentUserPhotoURL() async {
    final User? user = auth.currentUser;
    return user!.photoURL;
  }

  Future<bool> isUserSignedIn() async {
    final User? currentUser = auth.currentUser;
    return currentUser != null;
  }

  Future<void> deleteUser() async {
    final User? user = auth.currentUser;
    await user!.delete();
  }

  Future<void> reauthenticateUser(String email, String password) async {
    final User? user = auth.currentUser;
    final AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);
    await user!.reauthenticateWithCredential(credential);
  }

  Future<void> sendEmailVerificationToUser() async {
    final User? user = auth.currentUser;
    await user!.sendEmailVerification();
  }

  Future<bool> isUserEmailVerified() async {
    final User? user = auth.currentUser;
    return user!.emailVerified;
  }

  Future<void> changeUserPassword(String password) async {
    final User? user = auth.currentUser;
    await user!.updatePassword(password);
  }

  Future<void> changeUserEmail(String email) async {
    final User? user = auth.currentUser;
    await user!.updateEmail(email);
  }

  Future<void> changeUserDisplayName(String displayName) async {
    final User? user = auth.currentUser;
    await user!.updateDisplayName(displayName);
  }

  Future<void> changeUserPhotoURL(String photoURL) async {
    final User? user = auth.currentUser;
    await user!.updatePhotoURL(photoURL);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> changeUserEmailWithLink(String email) async {
    await auth.verifyPasswordResetCode(email);
  }

  Future<void> changeUserPasswordWithLink(String password) async {
    await auth.verifyPasswordResetCode(password);
  }

  Future<void> deleteUserAccount() async {
    final User? user = auth.currentUser;
    await user!.delete();
  }

  void saveUserInfo(
      String collectionName, Map<String, dynamic> data, String uid) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(uid)
        .set(data)
        .then((value) => print("User Info Added"))
        .catchError((error) => print("Failed to add user: $error"));

  }

}
//firebase_auth_service.dart
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter/material.dart';
//
// // class FirebaseAuthService {
// //   FirebaseAuth auth = FirebaseAuth.instance;
// //
// //   Future login(String email, String password) async {
// //     await auth.signInWithEmailAndPassword(email: email, password: password);
// //   }
// //
// //   Future signup(String email, String password) async {
// //     await auth.createUserWithEmailAndPassword(email: email, password: password);
// //   }
// //
// //   Future<void> logininwithgoogle() async {
// //     try {
// //       GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
// //       if (googleUser == null) {
// //         // User canceled the sign-in
// //         return;
// //       }
// //
// //       GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
// //
// //       AuthCredential myCredential = GoogleAuthProvider.credential(
// //         accessToken: googleAuth.accessToken,
// //         idToken: googleAuth.idToken,
// //       );
// //
// //       UserCredential user =
// //           await FirebaseAuth.instance.signInWithCredential(myCredential);
// //
// //       debugPrint(
// //           "Google Sign-In successful. User Display Name: ${user.user?.displayName}");
// //     } catch (e, stackTrace) {
// //       // Handle Google Sign-In errors
// //       print("Google Sign-In Error: $e");
// //       print("StackTrace: $stackTrace");
// //       throw Exception("Error during Google Sign-In");
// //     }
// //   }
// // }

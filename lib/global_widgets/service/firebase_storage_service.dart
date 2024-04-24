import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<void> uploadFile(String fileName, String filePath) async {
    File file = File(filePath);
    try {
      await firebaseStorage.ref('Files/$fileName').putFile(file).then((p0) {
        log("Uploaded");
      });
    } catch (e) {
      log("Error: $e");
    }
  }

  Future<ListResult> listFiles() async {
    ListResult listResults = await firebaseStorage.ref("Files").listAll();
    return listResults;
  }
}

// Audio service class with error handling
class AudioService {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instanceFor(
      bucket: "gs://stressshield-833ce.appspot.com");

  Future<ListResult> listFiles() async {
    ListResult listResults = await firebaseStorage.ref("audio").listAll();
    return listResults;
  }

  // Get audio file URL with error handling
  Future<String> getAudioFileUrl(String fileName) async {
    try {
      String url =
          await firebaseStorage.ref("audio/$fileName").getDownloadURL();
      return url;
    } catch (error) {
      // Handle error by logging or providing a default URL
      print("Error getting audio file URL: $error");
      return ""; // Or provide a default URL here
    }
  }
}

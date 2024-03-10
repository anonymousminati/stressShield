import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadAudio(String filePath) async {
    try {
      final fileName = basename(filePath); // Extract filename
      final reference = _storage.ref().child('audio/$fileName');
      final task = reference.putFile(File(filePath));
      final snapshot = await task.whenComplete(() => null);
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading audio: $e');
      throw Exception('Failed to upload audio');
    }
  }

  Future<String> getAudioUrl(String fileName) async {
    try {
      final reference = _storage.ref().child('audio/$fileName');
      return await reference.getDownloadURL();
    } catch (e) {
      print('Error getting audio URL: $e');
      throw Exception('Failed to get audio URL');
    }
  }
}

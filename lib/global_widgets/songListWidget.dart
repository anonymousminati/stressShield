import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class SongListWidget extends StatefulWidget {
  final AsyncSnapshot<DocumentSnapshot> snapshot;
  final String detectedLabel;
  final Function(Map<String, dynamic>) onSongClicked; // Callback function

  const SongListWidget({
    Key? key,
    required this.snapshot,
    required this.detectedLabel,
    required this.onSongClicked,
  }) : super(key: key);

  @override
  State<SongListWidget> createState() => _SongListWidgetState();
}

class _SongListWidgetState extends State<SongListWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }
    if (!widget.snapshot.hasData ||
        widget.snapshot.data == null ||
        !widget.snapshot.data!.exists) {
      return Center(
        child: Text(
          'No songs found for ${widget.detectedLabel}',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }

    // Extract the list of songs from the document data
    List<dynamic>? songsData = widget.snapshot.data!.get('musics');
    if (songsData == null || songsData.isEmpty) {
      return Center(
        child: Text(
          'No songs found for ${widget.detectedLabel}',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }

    // Display the list of songs
    return ListView.builder(
      itemCount: songsData.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final song = songsData[index];
        return GestureDetector(
          onTap: () {
            // Call the callback function to play the song
            widget.onSongClicked(song);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Text(
                  song['name'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(song['image_url']),
                ),
                trailing: Icon(Icons.play_arrow, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}

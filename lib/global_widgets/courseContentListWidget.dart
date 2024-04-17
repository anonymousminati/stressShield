import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:stress_sheild/feature/mindful_resources/screens/playcourse.dart';

class CourseAudioListWidget extends StatelessWidget {
  const CourseAudioListWidget({
    Key? key,
    required this.musicList,
    required this.playAudio,
  }) : super(key: key);

  final List<Map<String, dynamic>> musicList;
  final Function(String, String, String) playAudio;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: _buildAudioList(),
      ),
    );
  }

  Widget _buildAudioList() {
    print('musicList: ${musicList.length}');
    return musicList.isNotEmpty
        ? ListView.builder(
      itemCount: musicList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlayCourse(audioUrl:  musicList[index]['song_url'].toString(), audioTitle: musicList[index]['name'].toString(), imageUrl: musicList[index]['image_url'].toString(),),
              ),
            );

            print("musicList[index]['song_url'].toString(): ${musicList[index]['song_url'].toString()}");

            // playAudio(
            //   musicList[index]['song_url'].toString(),
            //   musicList[index]['name'].toString(),
            //   musicList[index]['image_url'].toString(),
            // );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueGrey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Text(
                  musicList[index]['name'].toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    musicList[index]['image_url'].toString(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    )
        : Center(
      child: Text(
        'There is no Audio list',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

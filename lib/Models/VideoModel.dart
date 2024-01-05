// ignore_for_file: file_names

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class VideoPost {
  String postId;
  String caption;
  String reference;
  String videoYoutubeLink;

  VideoPost({
    required this.postId,
    required this.caption,
    required this.reference,
    required this.videoYoutubeLink,
  });

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'caption': caption,
      'reference': reference,
      'videoYoutubeLink': videoYoutubeLink,
    };
  }

  factory VideoPost.fromMap(Map<String, dynamic> map) {
    return VideoPost(
      postId: map['postId'] ?? '',
      caption: map['caption'] ?? '',
      reference: map['reference'] ?? '',
      videoYoutubeLink: map['videoYoutubeLink'] ?? '',
    );
  }

  static Future<List<VideoPost>> getVideoPosts(String userId) async {
    try {
      // Assuming you are using Firestore as the database
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('videoPosts')
              .where('userId', isEqualTo: userId)
              .get();

      return snapshot.docs.map((doc) => VideoPost.fromMap(doc.data())).toList();
    } catch (error) {
      log('Error fetching video posts: $error');
      return [];
    }
  }
}

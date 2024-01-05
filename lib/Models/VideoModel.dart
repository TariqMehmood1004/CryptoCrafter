// ignore_for_file: file_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class VideoPost {
  String postId;
  String caption;
  String reference;
  String videoYoutubeLink;
  String uploadedBy;
  DateTime createdAt;

  VideoPost({
    required this.postId,
    required this.caption,
    required this.reference,
    required this.videoYoutubeLink,
    required this.uploadedBy,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'caption': caption,
      'reference': reference,
      'videoYoutubeLink': videoYoutubeLink,
      'uploadedBy': uploadedBy,
      'createdAt': createdAt,
    };
  }

  factory VideoPost.fromMap(Map<String, dynamic> map) {
    return VideoPost(
      postId: map['postId'] ?? '',
      caption: map['caption'] ?? '',
      reference: map['reference'] ?? '',
      videoYoutubeLink: map['videoYoutubeLink'] ?? '',
      uploadedBy: map['uploadedBy'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

class VideoPostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadVideo(String filePath) async {
    Reference ref = _storage
        .ref()
        .child('videoPosts/videos/${DateTime.now().millisecondsSinceEpoch}');
    UploadTask uploadTask = ref.putFile(File(filePath));
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> addVideoPost(VideoPost post) async {
    CollectionReference videoPosts = _firestore.collection('videoPosts');
    DocumentReference documentReference = await videoPosts.add(post.toMap());

    // Update the post ID
    post.postId = documentReference.id;
    await documentReference.update({'postId': post.postId});
  }

  Future<List<VideoPost>> getUserVideoPosts(String userId) async {
    CollectionReference videoPosts = _firestore.collection('videoPosts');
    QuerySnapshot querySnapshot =
        await videoPosts.where('uploadedBy', isEqualTo: userId).get();
    List<VideoPost> posts = querySnapshot.docs
        .map((doc) => VideoPost.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    return posts;
  }

  Future<VideoPost> getVideoPostById(String postId) async {
    CollectionReference videoPosts = _firestore.collection('videoPosts');
    DocumentSnapshot documentSnapshot = await videoPosts.doc(postId).get();
    VideoPost post =
        VideoPost.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    return post;
  }
}

// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImagePost {
  String? id;
  String? imageUrl;
  String? caption;
  String? uploadedBy;
  bool isAdminPosted;
  Timestamp? createdAt;

  ImagePost({
    this.id,
    this.imageUrl,
    this.caption,
    this.uploadedBy,
    this.isAdminPosted = false,
    this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'imageUrl': imageUrl,
        'caption': caption,
        'uploadedBy': uploadedBy,
        'isAdminPosted': isAdminPosted,
        'createdAt': createdAt,
      };

  static ImagePost fromJson(Map<String, dynamic> json) => ImagePost(
        id: json['id'],
        imageUrl: json['imageUrl'],
        caption: json['caption'],
        uploadedBy: json['uploadedBy'],
        isAdminPosted: json['isAdminPosted'],
        createdAt: json['createdAt'],
      );
}

class AddImagePostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(String filePath) async {
    Reference ref = _storage
        .ref()
        .child('posts/images/${DateTime.now().millisecondsSinceEpoch}');
    UploadTask uploadTask = ref.putFile(File(filePath));
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> addImagePost(ImagePost post) async {
    CollectionReference posts = _firestore.collection('posts');
    DocumentReference documentReference = await posts.add(post.toJson());

    // Update the post ID
    post.id = documentReference.id;
    await documentReference.update({'id': post.id});
  }

  Future<List<ImagePost>> getUserImagePosts(String userId) async {
    CollectionReference posts = _firestore.collection('posts');
    QuerySnapshot querySnapshot =
        await posts.where('uploadedBy', isEqualTo: userId).get();
    List<ImagePost> post = querySnapshot.docs
        .map((doc) => ImagePost.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return post;
  }

  Future<ImagePost> getImagePostById(String postId) async {
    CollectionReference posts = _firestore.collection('posts');
    DocumentSnapshot documentSnapshot = await posts.doc(postId).get();
    ImagePost post =
        ImagePost.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    return post;
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImagePost {
  String? imageUrl;
  String? caption;
  String? uploadedBy;
  bool isAdminPosted;
  Timestamp? createdAt;

  ImagePost({
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
    await posts.add(post.toJson());
  }
}

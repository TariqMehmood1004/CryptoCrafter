// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddVideoPost extends StatefulWidget {
  const AddVideoPost({Key? key}) : super(key: key);

  @override
  _AddVideoPostState createState() => _AddVideoPostState();
}

class _AddVideoPostState extends State<AddVideoPost> {
  final TextEditingController captionController = TextEditingController();
  final TextEditingController referenceController = TextEditingController();
  final TextEditingController videoLinkController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String _userId = '';

  void _addVideoPost() async {
    try {
      String postId =
          FirebaseFirestore.instance.collection('videoPosts').doc().id;

      // Add to Firestore
      await FirebaseFirestore.instance
          .collection('videoPosts')
          .doc(postId)
          .set({
        'postId': postId,
        'caption': captionController.text,
        'reference': referenceController.text,
        'videoYoutubeLink': videoLinkController.text,
        'uploadedBy': _userId,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Add to Realtime Database
      FirebaseDatabase.instance
          .reference()
          .child('videoPosts')
          .child(postId)
          .set({
        'postId': postId,
        'caption': captionController.text,
        'reference': referenceController.text,
        'videoYoutubeLink': videoLinkController.text,
        'uploadedBy': _userId,
        'createdAt': ServerValue.timestamp,
      });

      // Clear the text controllers after posting
      captionController.clear();
      referenceController.clear();
      videoLinkController.clear();

      // Optional: Show a success message or navigate to a different screen
      log('Video post added successfully!');
    } catch (error) {
      // Handle errors appropriately (e.g., show an error message)
      log('Error adding video post: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
        if (_user != null) {
          _userId = _user!.uid;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Video Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: captionController,
              decoration: const InputDecoration(labelText: 'Caption'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: referenceController,
              decoration: const InputDecoration(labelText: 'Reference'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: videoLinkController,
              decoration:
                  const InputDecoration(labelText: 'Video YouTube Link'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addVideoPost,
              child: const Text('Add Video Post'),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:trading_app/Models/AdminModel.dart';
import 'package:trading_app/Models/VideoModel.dart';

class AddVideoPost extends StatefulWidget {
  const AddVideoPost({Key? key}) : super(key: key);

  @override
  _AddVideoPostState createState() => _AddVideoPostState();
}

class _AddVideoPostState extends State<AddVideoPost> {
  final TextEditingController captionController = TextEditingController();
  final TextEditingController referenceController = TextEditingController();
  final TextEditingController videoLinkController = TextEditingController();

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
        'uploadedBy': 'loggedInUserId', // Replace with actual user ID
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
        'uploadedBy': 'loggedInUserId', // Replace with actual user ID
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

class VideoPostList extends StatelessWidget {
  const VideoPostList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Posts'),
      ),
      body: FutureBuilder(
        future: VideoPost.getVideoPosts('loggedInUserId'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<VideoPost> videoPosts = snapshot.data as List<VideoPost>;
            return ListView.builder(
              itemCount: videoPosts.length,
              itemBuilder: (context, index) {
                VideoPost videoPost = videoPosts[index];
                return ListTile(
                  title: Text(videoPost.caption),
                  subtitle: Text(videoPost.reference),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {
                      // Open the video player with the videoPost.videoYoutubeLink
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class ShowVideoPost extends StatelessWidget {
  final VideoPost videoPost;

  const ShowVideoPost({Key? key, required this.videoPost}) : super(key: key);

  String getFirstThreeWords(String text) {
    List<String> words = text.split(' ');
    return words.length >= 3 ? '${words[0]} ${words[1]} ${words[2]}' : text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text(
          getFirstThreeWords(videoPost.caption),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  videoPost.reference,
                  fit: BoxFit.cover,
                  height: 300,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              videoPost.caption,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
                color: Colors.black87,
                height: 1.5,
                letterSpacing: 0.5,
                wordSpacing: 0.5,
                textBaseline: TextBaseline.alphabetic,
              ),
            ),
            const SizedBox(height: 2.0),
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('admins')
                  .doc(videoPost.uploadedBy)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  AdminModel admin = AdminModel.fromMap(snapshot.data!.data()!);
                  return Text(
                      'Posted by ${admin.displayName} on ${videoPost.createdAt.toLocal().toIso8601String()}');
                } else {
                  return const Text('Loading...');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

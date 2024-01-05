// ignore_for_file: use_build_context_synchronously, unused_field, camel_case_types

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trading_app/firebase_services/add_image_post.dart';
import 'package:trading_app/screens/admin/add_post/views/show_image_post.dart';
import 'package:trading_app/utils/navigator.dart';

class AddImagePost extends StatefulWidget {
  const AddImagePost({super.key});

  @override
  State<AddImagePost> createState() => _AddImagePostState();
}

class _AddImagePostState extends State<AddImagePost> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String? _imageUrl;
  String? _caption;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String _userId = '';

  AddImagePostService addImagePostService = AddImagePostService();

  List<ImagePost> _userPosts = [];

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
        if (_user != null) {
          _userId = _user!.uid;
          getUserImagePosts();
        }
      });
    });
  }

  Future<void> getUserImagePosts() async {
    _userPosts = await addImagePostService.getUserImagePosts(_userId);
    setState(() {});
  }

  String getLimitedWords(String text, int lengthWords) {
    List<String> words = text.split(' ');
    return words.length >= lengthWords
        ? words.take(lengthWords).join(' ')
        : text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Image Post'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    _image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {});
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      image: _image != null
                          ? DecorationImage(
                              image: FileImage(File(_image!.path)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _image == null
                        ? const Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Caption',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _caption = value;
                    });
                  },
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                ),
              ),
              const SizedBox(height: 20),
              myButtonWidget(
                image: _image,
                caption: _caption,
                addImagePostService: addImagePostService,
                userId: _userId,
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    'Your Posts:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Lobster',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _userPosts.isNotEmpty
                  ? ListView.builder(
                      itemCount: _userPosts.length,
                      itemBuilder: (context, index) {
                        ImagePost post = _userPosts[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                              getLimitedWords(post.caption ?? '', 10),
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Posted on ${post.createdAt!.toDate()}',
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            trailing: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                post.imageUrl ?? '',
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            onTap: () async {
                              pushToScreen(
                                  context, ShowImagePost(imagePost: post));
                            },
                          ),
                        );
                      },
                    )
                  : const Text('No posts yet.'),
            ],
          ),
        ),
      ),
    );
  }
}

class myButtonWidget extends StatelessWidget {
  const myButtonWidget({
    super.key,
    required XFile? image,
    required String? caption,
    required this.addImagePostService,
    required String userId,
  })  : _image = image,
        _caption = caption,
        _userId = userId;

  final XFile? _image;
  final String? _caption;
  final AddImagePostService addImagePostService;
  final String _userId;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        if (_image != null && _caption != null) {
          // Upload image to Firebase Storage
          String imageUrl = await addImagePostService.uploadImage(_image!.path);

          // Add post to Firestore
          ImagePost post = ImagePost(
            imageUrl: imageUrl,
            caption: _caption,
            uploadedBy: _userId,
            isAdminPosted: true,
            createdAt: Timestamp.now(),
          );
          await addImagePostService.addImagePost(post);

          // Navigate back to home page
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select an image and enter a caption.'),
            ),
          );
        }
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          )),
      child: const Text('Add Post'),
    );
  }
}

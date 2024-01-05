// ignore_for_file: use_build_context_synchronously, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trading_app/firebase_services/add_image_post.dart';

class MyButtonWidget extends StatelessWidget {
  const MyButtonWidget({
    Key? key,
    required XFile? image,
    required String? caption,
    required this.addImagePostService,
    required String userId,
  })  : _image = image,
        _caption = caption,
        _userId = userId,
        super(key: key);

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
          String imageUrl = await addImagePostService.uploadImage(_image.path);

          // Add post to Firestore
          ImagePost post = ImagePost(
            imageUrl: imageUrl,
            caption: _caption,
            uploadedBy: _userId,
            isAdminPosted: true,
            createdAt: Timestamp.now(),
          );
          await addImagePostService.addImagePost(post);

          // Navigate back to the home page
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
        ),
      ),
      child: const Text('Add Post'),
    );
  }
}

// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unused_field

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trading_app/firebase_services/add_image_post.dart';

class AddImagePost extends StatefulWidget {
  const AddImagePost({super.key});

  @override
  _AddImagePostState createState() => _AddImagePostState();
}

class _AddImagePostState extends State<AddImagePost> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String? _imageUrl;
  String? _caption;

  AddImagePostService addImagePostService = AddImagePostService();

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
                    width: 200,
                    height: 200,
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
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Caption',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _caption = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_image != null && _caption != null) {
                    // Upload image to Firebase Storage
                    String imageUrl =
                        await addImagePostService.uploadImage(_image!.path);

                    // Add post to Firestore
                    await addImagePostService.addImagePost(
                        imageUrl, _caption!, "Admin");

                    // Navigate back to home page
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Please select an image and enter a caption.'),
                      ),
                    );
                  }
                },
                child: const Text('Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

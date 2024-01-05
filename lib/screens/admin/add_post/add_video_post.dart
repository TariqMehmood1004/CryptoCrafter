import 'package:flutter/material.dart';

class AddVideoPost extends StatefulWidget {
  const AddVideoPost({super.key});

  @override
  State<AddVideoPost> createState() => _AddVideoPostState();
}

class _AddVideoPostState extends State<AddVideoPost> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Add Video Post'),
    );
  }
}

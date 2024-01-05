import 'package:flutter/material.dart';

class AddArticlePost extends StatefulWidget {
  const AddArticlePost({super.key});

  @override
  State<AddArticlePost> createState() => _AddArticlePostState();
}

class _AddArticlePostState extends State<AddArticlePost> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Add Article Post'),
    );
  }
}

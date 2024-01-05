import 'package:flutter/material.dart';

class AddVoiceMessagePost extends StatefulWidget {
  const AddVoiceMessagePost({super.key});

  @override
  State<AddVoiceMessagePost> createState() => _AddVoiceMessagePostState();
}

class _AddVoiceMessagePostState extends State<AddVoiceMessagePost> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Add Voice Message Post'),
    );
  }
}

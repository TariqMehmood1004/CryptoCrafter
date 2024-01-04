import 'package:flutter/material.dart';

class GuestMode extends StatefulWidget {
  const GuestMode({super.key});

  @override
  State<GuestMode> createState() => _GuestModeState();
}

class _GuestModeState extends State<GuestMode> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Guest Mode'),
    );
  }
}

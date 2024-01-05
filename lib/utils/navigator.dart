import 'package:flutter/material.dart';

void pushToScreen(BuildContext context, addImagePostScreen) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => addImagePostScreen),
    );

void pushReplacementToScreen({context, screen}) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );

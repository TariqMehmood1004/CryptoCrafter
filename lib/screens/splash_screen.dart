// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:trading_app/screens/authentication.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
        context,
        MaterialPageRoute(builder: (context) => const AuthScreen()) as String,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text(
            'CryptoCrafter',
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}

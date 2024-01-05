// Provide me the statefulwidget for this file

import 'package:flutter/material.dart';

class AddCoinMarketCapPost extends StatefulWidget {
  const AddCoinMarketCapPost({super.key});

  @override
  State<AddCoinMarketCapPost> createState() => _AddCoinMarketCapPostState();
}

class _AddCoinMarketCapPostState extends State<AddCoinMarketCapPost> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Add CoinMarketCap Post'),
    );
  }
}

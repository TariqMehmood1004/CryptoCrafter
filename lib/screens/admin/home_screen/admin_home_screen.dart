// ignore_for_file: use_key_in_widget_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CryptoCrafter Admin Home'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildPostCard(
              'Post with Image',
              'Description of the post with an image.',
              '',
            ),
            buildPostCard(
              'Post with Video',
              'Description of the post with a video.',
              'youtube_video_url_here',
            ),
            buildPostCard(
              'Post with Voice Message',
              'Description of the post with a voice message.',
              "", // Voice message URL goes here
            ),
            buildPostCard(
              'Post with Multiple URLs',
              'Description of the post with multiple URLs.',
              "", // You can display multiple URLs here
            ),
            buildPostCardWithExternalLink(
              'Post with External Link',
              'Description of the post with an external link.',
              'https://play.google.com/store/apps/details?id=com.candlesticsignalsandpatterns.app&hl=en_US',
            ),
            buildPostCardWithExternalLink(
              'Post with CoinmarketCap Integration',
              'Description of the post with CoinmarketCap integration.',
              'https://coinmarketcap.com/',
            ),
            buildPostCardWithExternalLink(
              'Post with Shared Article',
              'Description of the post with a shared article.',
              'https://coinmarketcap.com/community/articles/65851c7a76f2e4352192b5cf/',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPostCard(String title, String description, String mediaUrl) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          mediaUrl != null
              ? Image.network(mediaUrl)
              : Container(), // Display image or video thumbnail
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(description),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPostCardWithExternalLink(
      String title, String description, String externalLink) {
    return GestureDetector(
      onTap: () {
        // Handle tapping on the external link
        // You can use packages like url_launcher to open external links
      },
      child: Card(
        elevation: 3.0,
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(description),
                  const SizedBox(height: 8.0),
                  Text(
                    'Reference Link: $externalLink',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

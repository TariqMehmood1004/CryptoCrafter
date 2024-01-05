// ignore_for_file: use_key_in_widget_constructors, unnecessary_null_comparison

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:trading_app/screens/admin/add_post/add_article_post.dart';
import 'package:trading_app/screens/admin/add_post/add_coinmarketcap_post.dart';
import 'package:trading_app/screens/admin/add_post/add_external_link_post.dart';
import 'package:trading_app/screens/admin/add_post/add_image_post.dart';
import 'package:trading_app/screens/admin/add_post/add_video_post.dart';
import 'package:trading_app/screens/admin/add_post/add_voice_message_post.dart';
import 'package:trading_app/utils/navigator.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('CryptoCrafter Admin Home'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildPostCard(
                'Post with Image',
                'Description of the post with an image.',
                "https://techcrunch.com/wp-content/uploads/2022/11/postnews.jpg",
                onTap: () {
              log('Post with Image clicked');
              pushToScreen(context, const AddImagePost());
            }),
            buildPostCard(
                'Post with Video',
                'Description of the post with a video.',
                'https://images.pexels.com/photos/5650141/pexels-photo-5650141.jpeg?auto=compress&cs=tinysrgb&w=600',
                onTap: () {
              log('Post with Video clicked');
              pushToScreen(context, const AddVideoPost());
            }),
            buildPostCard(
                'Post with Voice Message',
                'Description of the post with a voice message.',
                "https://images.pexels.com/photos/5939401/pexels-photo-5939401.jpeg?auto=compress&cs=tinysrgb&w=600",
                onTap: () {
              log('Post with Voice Message clicked');
              pushToScreen(context, const AddVoiceMessagePost());
            }),
            buildPostCardWithExternalLink(
                'Post with External Link',
                'Description of the post with an external link.',
                'https://images.unsplash.com/photo-1584714268709-c3dd9c92b378?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fFVybHN8ZW58MHx8MHx8fDA%3D',
                onTap: () {
              log('Post with External Link clicked');
              pushToScreen(context, const AddExternalLinksPost());
            }),
            buildPostCardWithExternalLink(
                'Post with CoinmarketCap Integration',
                'Description of the post with CoinmarketCap integration.',
                'https://coinmarketcap.com/', onTap: () {
              log('Post with CoinmarketCap Integration clicked');
              pushToScreen(context, const AddCoinMarketCapPost());
            }),
            buildPostCardWithExternalLink(
                'Post with Shared Article',
                'Description of the post with a shared article.',
                'https://coinmarketcap.com/community/articles/65851c7a76f2e4352192b5cf/',
                onTap: () {
              log('Post with Shared Article clicked');
              pushToScreen(context, const AddArticlePost());
            }),
          ],
        ),
      ),
    );
  }

  Widget buildPostCard(String title, String description, String mediaUrl,
      {void Function()? onTap}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: Colors.white,
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
        ),
      ),
    );
  }

  Widget buildPostCardWithExternalLink(
      String title, String description, String externalLink,
      {void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
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

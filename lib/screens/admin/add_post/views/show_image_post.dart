import 'package:flutter/material.dart';
import 'package:trading_app/firebase_services/add_image_post.dart';

class ShowImagePost extends StatelessWidget {
  final ImagePost imagePost;

  const ShowImagePost({super.key, required this.imagePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(imagePost.caption ?? ''),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Image.network(imagePost.imageUrl ?? ''),
            ),
            const SizedBox(height: 20),
            Text(
              imagePost.caption ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 2.0),
            Text(
                'Posted by ${imagePost.uploadedBy} on ${imagePost.createdAt!.toDate()}'),
          ],
        ),
      ),
    );
  }
}

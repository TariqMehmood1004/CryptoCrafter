import 'package:flutter/material.dart';
import 'package:trading_app/firebase_services/add_image_post.dart';

class ShowImagePost extends StatelessWidget {
  final ImagePost imagePost;

  const ShowImagePost({super.key, required this.imagePost});

  String getFirstThreeWords(String text) {
    List<String> words = text.split(' ');
    return words.length >= 3 ? '${words[0]} ${words[1]} ${words[2]}' : text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text(
          getFirstThreeWords(imagePost.caption ?? ''),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imagePost.imageUrl ?? '',
                  fit: BoxFit.cover,
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: MediaQuery.sizeOf(context).height * 0.5,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Text(
                  'Article',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1.5,
                    letterSpacing: 0.5,
                    wordSpacing: 0.5,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7.0),
            Text(
              imagePost.caption ?? '',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
                height: 1.5,
                letterSpacing: 0.5,
                wordSpacing: 0.5,
                textBaseline: TextBaseline.alphabetic,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Posted by ${imagePost.isAdminPosted ? 'Admin' : 'User'}',
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    height: 1.5,
                    letterSpacing: 0.5,
                    wordSpacing: 0.5,
                    textBaseline: TextBaseline.alphabetic,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  '${imagePost.createdAt!.toDate()}',
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Color.fromRGBO(42, 117, 179, 1),
                    height: 1.5,
                    letterSpacing: 0.5,
                    wordSpacing: 0.5,
                    textBaseline: TextBaseline.alphabetic,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

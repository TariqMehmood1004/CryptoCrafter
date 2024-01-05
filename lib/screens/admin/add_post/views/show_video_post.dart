// ignore_for_file: prefer_final_fields, unused_field, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trading_app/Models/VideoModel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShowAllVideoPosts extends StatefulWidget {
  final List<VideoPost> videoPosts;

  const ShowAllVideoPosts({super.key, required this.videoPosts});

  @override
  State<ShowAllVideoPosts> createState() => _ShowAllVideoPostsState();
}

class _ShowAllVideoPostsState extends State<ShowAllVideoPosts> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String _userId = '';

  VideoPostService _videoPost = VideoPostService();

  List<VideoPost> _userPosts = [];

  String getLimitedWords(String text, int lengthWords) =>
      text.split(' ').take(lengthWords).join(' ');

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
        if (_user != null) {
          _userId = _user!.uid;
          getUserVideoPosts();
        }
      });
    });
  }

  Future<void> getUserVideoPosts() async {
    _userPosts = await _videoPost.getUserVideoPosts(_userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show All Video Posts'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: widget.videoPosts.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: widget.videoPosts.length,
                itemBuilder: (context, index) {
                  VideoPost post = widget.videoPosts[index];
                  String videoId =
                      _getVideoId(post.videoYoutubeLink.toString());
                  YoutubePlayerController controller = YoutubePlayerController(
                    initialVideoId: videoId,
                    flags: const YoutubePlayerFlags(
                      autoPlay: false,
                      mute: false,
                    ),
                  );
                  return Card(
                    elevation: 12,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 5.0),
                    clipBehavior: Clip.antiAlias,
                    semanticContainer: true,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Colors.black,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                          child: post.videoYoutubeLink != null
                              ? YoutubePlayer(
                                  controller: controller,
                                  aspectRatio: 16 / 9,
                                  onReady: () => post.videoYoutubeLink != null
                                      ? controller.value.isPlaying
                                          ? controller.pause()
                                          : controller.play()
                                      : null,
                                )
                              : Container(),
                        ),
                        ListTile(
                          title: Text(
                            getLimitedWords(post.caption, 10),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Posted on ${post.createdAt.toLocal()}',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                            ),
                            onPressed: () => post.videoYoutubeLink != null
                                ? controller.value.isPlaying
                                    ? controller.pause()
                                    : controller.play()
                                : null,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : const Text('No posts yet.'),
      ),
    );
  }

  String _getVideoId(String? youtubeUrl) =>
      YoutubePlayer.convertUrlToId(youtubeUrl!) ?? '';
}

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video_player/video_player.dart';

class ShowVideo extends StatefulWidget {
  const ShowVideo({super.key, required this.url});
  final String url;
  @override
  State<ShowVideo> createState() => _ShowVideoState();
}

class _ShowVideoState extends State<ShowVideo> {
  late VideoPlayerController videoplayercontroller;
  late ChewieController chewiecontroller;
  bool initialize = false;

  @override
  void initState() {
    videoplayercontroller = VideoPlayerController.network(widget.url);
    videoplayercontroller.initialize().then((value) {
      chewiecontroller = ChewieController(
          videoPlayerController: videoplayercontroller,
          autoPlay: true,
          looping: false);
      initialize = true;
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    videoplayercontroller.dispose();
    chewiecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: initialize
            ? Chewie(controller: chewiecontroller)
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

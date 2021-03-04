import 'package:flutter/material.dart';
import 'package:paradox/models/gallery.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoCard extends StatefulWidget {
  final GalleryItem video;

  VideoCard({@required this.video});

  @override
  _LiveVideoCardState createState() => _LiveVideoCardState();
}

class _LiveVideoCardState extends State<VideoCard> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.url,
      params: YoutubePlayerParams(
        autoPlay: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: MediaQuery.of(context).size.height * .3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(width: 0.3),
            ),
            child: YoutubePlayerIFrame(
                key: ObjectKey(_controller),
                controller: _controller,
                aspectRatio: 16 / 9),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ExpandedImageView extends StatelessWidget {
  final image;

  ExpandedImageView({@required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: PhotoView(
                imageProvider: NetworkImage(image),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

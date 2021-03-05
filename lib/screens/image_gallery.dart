import 'package:flutter/material.dart';
import 'package:paradox/models/gallery.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ExpandedImageGalleryView extends StatelessWidget {
  List<GalleryItem> images;
  int initialPage;

  ExpandedImageGalleryView({@required this.images, @required this.initialPage});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage:initialPage );
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
                child: PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  pageController: pageController,
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(images[index].url),
                      initialScale: PhotoViewComputedScale.contained * 0.8,
                      heroAttributes: PhotoViewHeroAttributes(tag: images[index]),
                    );
                  },
                  itemCount: images.length,
                  loadingBuilder: (context, event) => Center(
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        value: event == null
                            ? 0
                            : event.cumulativeBytesLoaded /
                            event.expectedTotalBytes,
                      ),
                    ),
                  ),
                  // backgroundDecoration: widget.backgroundDecoration,
                  // pageController: widget.pageController,
                  // onPageChanged: onPageChanged,
                )),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_sharp,
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

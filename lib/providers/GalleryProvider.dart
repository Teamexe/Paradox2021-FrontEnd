import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:paradox/models/gallery.dart';
import 'package:paradox/utilities/constant.dart';

class GalleryProvider extends ChangeNotifier {
  List<GalleryItem> _images = [];
  List<GalleryItem> _videos = [];

  List<GalleryItem> get images => [..._images];

  Future<void> fetchAndSetGallery() async {
    String route = "exe-gallery/";

    String url = "$baseUrl$route";

    Response response = await get(url);
    try {
      if (response.statusCode == 200) {
        _images.clear();
        _videos.clear();

        /// Decoding Response Received
        var data = jsonDecode(response.body);
        for (int i = 0; i < data.length; i++) {
          GalleryItem item = new GalleryItem(url : data[i]['url'], credit: data[i]['credit'], category: data[i]['type']);
          if (item.category == "Image")
            _images.add(item);
          else
            _videos.add(item);
        }

        /// Notifying Listeners
        notifyListeners();
      } else {
        throw Exception();
      }
    } catch (e) {

      throw Exception();
    }
  }

  List<GalleryItem> get videos => [..._videos];
}

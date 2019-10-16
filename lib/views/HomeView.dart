import 'package:flutter/material.dart';
import 'package:epicture/managers/imgur/Gallery.dart';
import 'package:epicture/models/GalleryList.dart';
import 'package:epicture/components/ImageViewer.dart';

class HomeView extends StatefulWidget {
  HomeView({
    Key key,
  }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GalleryList galleryList;

  final favoriteNotTriggered = Icon(
    Icons.favorite_border,
    color: Colors.blueAccent,
  );
  final favoriteTriggered = Icon(Icons.favorite, color: Colors.redAccent);

  _HomeViewState() {
    Gallery().getGallery({
      "section": "hot",
      "sort": "viral",
      "page": "1",
      "window": "day"
    }, {
      "showViral": true,
      "showMature": false,
      "albumPreviews": false
    }).then((GalleryList list) {
      setState(() {
        this.galleryList = list;
        // Sort files to keep only images
        this.galleryList.gallery.removeWhere((i) => ((i.imagesInfo != null &&
                i.imagesInfo.length != 0 &&
                i.imagesInfo[0].type.contains('mp4')) ||
            (i.cover == null)));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (this.galleryList == null) {
      return CircularProgressIndicator();
    }
    return Container(
        child: ListView.builder(
      itemCount: this.galleryList.gallery.length,
      itemBuilder: (BuildContext context, int index) {
        return ImageViewer(image: this.galleryList.gallery[index], canPopContext: false, isFromUser: false);
      },
    ));
  }
}

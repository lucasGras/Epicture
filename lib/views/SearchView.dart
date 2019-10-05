import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:epicture/managers/imgur/Gallery.dart';
import 'package:epicture/models/GalleryList.dart';
import 'package:epicture/models/GalleryImage.dart';
import 'package:video_player/video_player.dart';

class SearchView extends StatefulWidget {
  SearchView({Key key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  GalleryList galleryList;
  final textInputController = TextEditingController();

  @override
  void dispose() {
    textInputController.dispose();
    super.dispose();
  }
  
  _SearchViewState() {
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      Gallery().getGalleryResearch("Cats").then((GalleryList list) {
        setState(() {
          this.galleryList = list;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (galleryList == null) {
      return CircularProgressIndicator();
    }
    return Container(
      child: Column(
        children: <Widget>[
          createSearchBar(context),
          createCardGrid(context)
        ],
      ),
    );
  }

  Widget createSearchBar(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: TextField(
          onSubmitted: (String search) {
            setState(() {
              Gallery().getGalleryResearch(search).then((GalleryList list) {
                setState(() {
                  this.galleryList = list;
                });
              });
            });
          },
          controller: this.textInputController,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: new Icon(Icons.search, color: Colors.grey),
              hintText: "Search...",
              hintStyle: new TextStyle(color: Colors.grey)
          )
      ),
    );
  }

  Widget createCardGrid(BuildContext context) {

    // Sort files to keep only images
    this.galleryList.gallery.removeWhere((i) => (
        i.imagesInfo != null && i.imagesInfo[0].type.contains('mp4')
        && i.cover != null
    ));

    return Flexible(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: this.galleryList.gallery.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return createResultCardImage(context, this.galleryList.gallery[index]);
          }
      )
    );
  }

  Widget createResultCardImage(BuildContext context, GalleryImage image) {
    return Container(
      child: Card(
        semanticContainer: true,
        child: GridTile(
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "https://i.imgur.com/" + image.cover + "." +
                          image.imagesInfo[0].type.split('/')[1]
                    )
                )
            ),
          ),
        )
      ),
    );
  }
}
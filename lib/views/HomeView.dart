import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:epicture/managers/imgur/Gallery.dart';
import 'package:epicture/models/GalleryList.dart';
import 'package:epicture/models/GalleryImage.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GalleryList galleryList;

  _HomeViewState() {
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      Gallery().getGallery({
        "section": "hot",
        "sort": "viral",
        "page": "2",
        "window": "day"
      }, {
        "showViral": true,
        "showMature": false,
        "albumPreviews": false
      }).then((GalleryList list) {
        setState(() {
          this.galleryList = list;
        });
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
        return Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(5),
                    child: createPostHeader(context, this.galleryList.gallery[index])
                ),
                createPostImage(context, this.galleryList.gallery[index]),
                createPostActions(context, this.galleryList.gallery[index]),
                createPostComments(context, this.galleryList.gallery[index])
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
        );
      },
    ));
  }

  Widget createPostHeader(BuildContext context, GalleryImage image) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('https://placeimg.com/640/480/any'))),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            image.username,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        )
      ],
    ));
  }

  Widget createPostImage(BuildContext context, GalleryImage image) {
    return Image.network(
      "https://i.imgur.com/" + image.cover + "." + image.imagesInfo[0].type.split('/')[1],
      fit: BoxFit.fill,
    );
  }

  Widget createPostActions(BuildContext context, GalleryImage image) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child:
                IconButton(icon: Icon(Icons.favorite_border), onPressed: null),
          ),
          Container(
            child: IconButton(icon: Icon(Icons.comment), onPressed: null),
          ),
          Container(
            padding: EdgeInsets.only(left: 200),
            child: Text(
              image.ups.toString() + " J'aime",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget createPostComments(BuildContext context, GalleryImage image) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(10),
      child: Text.rich(TextSpan(children: <TextSpan>[
        TextSpan(
            text: image.username + "  ",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11)),
        TextSpan(
            text: image.title,
            style: TextStyle(fontSize: 11))
      ])),
    );
  }
}

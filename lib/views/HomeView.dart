import 'package:flutter/material.dart';
import 'package:epicture/managers/imgur/Gallery.dart';
import 'package:epicture/models/GalleryList.dart';
import 'package:epicture/models/GalleryImage.dart';
import 'package:epicture/managers/imgur/Image.dart' as ImgurImage;

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GalleryList galleryList;

  final favoriteNotTriggered = Icon(Icons.favorite_border, color: Colors.blueAccent,);
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
        this.galleryList.gallery.removeWhere((i) => (
            (i.imagesInfo != null && i.imagesInfo.length != 0 && i.imagesInfo[0].type.contains('mp4'))
            || (i.cover == null)
        ));
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
                    child: createPostHeader(
                        context, this.galleryList.gallery[index])),
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
                      image: NetworkImage("https://imgur.com/user/" + image.username + "/avatar")
                  )
              ),
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
      "https://i.imgur.com/" +
          image.cover +
          "." +
          image.imagesInfo[0].type.split('/')[1],
      fit: BoxFit.fill,
    );
  }

  Widget createPostActions(BuildContext context, GalleryImage image) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child:
                IconButton(
                    icon: Icon(
                        Icons.thumb_up,
                        color: (image.vote != null && image.vote == "up") ? Colors.greenAccent : Colors.grey
                    ),
                    onPressed: () {
                      Gallery().voteImage(image.id, 'up').then((Map<String, dynamic> resp) {
                        setState(() {
                          image.vote = "up";
                        });
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("You just liked " + image.username + "'s post !"),
                          backgroundColor: Colors.greenAccent,
                        ));
                      });
                    }
                ),
          ),
          Container(
            child:
            IconButton(
                icon: Icon(
                    Icons.thumb_down,
                    color: (image.vote != null && image.vote == "down") ? Colors.redAccent : Colors.grey
                ),
                onPressed: () {
                  Gallery().voteImage(image.id, 'down').then((Map<String, dynamic> resp) {
                    setState(() {
                      image.vote = "down";
                    });
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("You just disliked " + image.username + "'s post !"),
                      backgroundColor: Colors.redAccent,
                    ));
                  });
                }
            ),
          ),/*
          Container(
            child: IconButton(icon: Icon(Icons.comment, color: Colors.blueAccent), onPressed: null),
          ),*/
          Container(
            child: IconButton(
                icon: Icon(Icons.save_alt, color: Colors.blueAccent),
                onPressed: () {
                  ImgurImage.Image().favoriteImage(image).then((Map<String, dynamic> resp) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Image saved in favorites !"),
                      backgroundColor: Colors.blueAccent,
                    ));
                  });
                }
            ),
          ),
          Spacer(),
          Container(
              margin: EdgeInsets.only(right: 20),
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
        TextSpan(text: image.title, style: TextStyle(fontSize: 11))
      ])),
    );
  }
}

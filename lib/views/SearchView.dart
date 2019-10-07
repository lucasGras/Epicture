import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:epicture/managers/imgur/Gallery.dart';
import 'package:epicture/models/GalleryList.dart';
import 'package:epicture/models/GalleryImage.dart';

class SearchView extends StatefulWidget {
    SearchView({Key key}) : super(key: key);

    @override
    _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
    GalleryList galleryList;
    final textInputController = TextEditingController();
    int currentSortingOption = 0;
    int currentWindowOption = 0;
    List<String> sortOptions = ["time", "viral", "top"];
    List<String> windowOptions = ["all", "day", "week", "month", "year"];
    String currentSearch = "Cat";

    @override
    void dispose() {
        textInputController.dispose();
        super.dispose();
    }

    _SearchViewState() {
        SharedPreferences.getInstance().then((SharedPreferences prefs) {
            Gallery().getGalleryResearch(this.currentSearch,
                this.sortOptions[this.currentSortingOption],
                this.windowOptions[this.currentWindowOption]).then((GalleryList list) {
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
            child: Column(
                children: <Widget>[
                Container(
                    alignment: Alignment.topCenter,
                    child: TextField(
                        onSubmitted: (String search) {
                            Gallery().getGalleryResearch(this.currentSearch,
                                this.sortOptions[this.currentSortingOption],
                                this.windowOptions[this.currentWindowOption]).then((GalleryList list) {
                                setState(() {
                                    this.galleryList = list;
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
                ),
                Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                            Container(
                                child: ButtonBar(
                                    children: <Widget>[
                                        RaisedButton(
                                            child: Text(this.sortOptions[this.currentSortingOption]),
                                            onPressed: () {
                                                this.currentSortingOption++;
                                                if (this.currentSortingOption >= this.sortOptions.length)
                                                    this.currentSortingOption = 0;
                                                Gallery().getGalleryResearch(this.currentSearch,
                                                    this.sortOptions[this.currentSortingOption],
                                                    this.windowOptions[this.currentWindowOption]).then((GalleryList list) {
                                                    setState(() {
                                                        this.galleryList = list;
                                                    });
                                                });
                                            },
                                        ),
                                        RaisedButton(
                                            child: Text(this.windowOptions[this.currentWindowOption]),
                                            onPressed: () {
                                                this.currentWindowOption++;
                                                if (this.currentWindowOption >= this.windowOptions.length)
                                                    this.currentWindowOption = 0;
                                                Gallery().getGalleryResearch(this.currentSearch,
                                                    this.sortOptions[this.currentSortingOption],
                                                    this.windowOptions[this.currentWindowOption]).then((GalleryList list) {
                                                    setState(() {
                                                        this.galleryList = list;
                                                    });
                                                });
                                            },
                                        )
                                    ],
                                ),
                            )
                        ],
                    ),
                ),
            ],
        ),);
    }

    Widget createCardGrid(BuildContext context) {
        // Sort files to keep only images
        this.galleryList.gallery.removeWhere((i) => (
            (i.imagesInfo != null && i.imagesInfo.length != 0 && i.imagesInfo[0].type.contains('mp4'))
                || (i.cover == null)
        ));

        return Flexible(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: this.galleryList.gallery.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                    return createResultCardImage(
                        context, this.galleryList.gallery[index]);
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
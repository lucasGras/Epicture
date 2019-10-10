import 'package:flutter/material.dart';
import 'dart:io';
import 'package:epicture/managers/imgur/Image.dart' as ImgurImage;

class NewView extends StatelessWidget {
    final File imageData;

    const NewView({Key key, this.imageData}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        if (this.imageData == null) {
            Navigator.pop(context);
        }
        return Scaffold(
            appBar: AppBar(title: Text('New pictures')),
            body: createView(context),
        );
    }

    Widget createView(BuildContext context) {
        return SingleChildScrollView(
            child: Column(
                children: <Widget>[
                    createImageUpload(context),
                    createImageUploadInformation(context)
                ],
            ),
        );
    }

    Widget createImageUploadInformation(BuildContext context) {
        return Container(
            padding: EdgeInsets.all(10),
            child: Column(
                children: <Widget>[
                    Container(
                        child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Title",
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(),
                                ),
                            ),
                        ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 5),
                        child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Description",
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(),
                                )
                            ),
                        ),
                    ),
                    Container(
                        padding: EdgeInsets.all(20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                                Container(
                                    child: IconButton(
                                        icon: Icon(Icons.add_circle, size: 50, color: Colors.blueAccent),
                                        onPressed: () {
                                            final snackBar = SnackBar(
                                                content: Text("Image uploaded !")
                                            );

                                            ImgurImage.Image().uploadImage({
                                                "image": this.imageData,
                                                "title": "",
                                                "description": ""
                                            }).then((Map<String, dynamic> json) {
                                                //Scaffold.of(context).showSnackBar(snackBar);
                                                Navigator.pop(context);
                                            });
                                        },
                                    ),
                                ),
                                Container(
                                    child: IconButton(
                                        icon: Icon(Icons.cancel, size: 50, color: Colors.redAccent),
                                        onPressed: () {
                                            Navigator.pop(context);
                                        },
                                    ),
                                )
                            ],
                        ),
                    )
                ],
            ),
        );
    }

    Widget createImageUpload(BuildContext context) {
        return Container(
            padding: EdgeInsets.all(25),
            child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.file(
                    this.imageData,
                ),
            ),
        );
    }
}

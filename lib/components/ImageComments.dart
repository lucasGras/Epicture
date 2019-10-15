import 'package:flutter/material.dart';
import 'package:epicture/models/CommentList.dart';
import 'package:epicture/models/Comment.dart';
import 'package:epicture/models/GalleryImage.dart';
import 'package:epicture/managers/imgur/Gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:epicture/managers/imgur/Comment.dart' as CommentManager;

class ImageComments extends StatefulWidget {
  final GalleryImage image;

  ImageComments({Key key, @required this.image}) : super(key: key);

  @override
  _ImageCommentsState createState() => _ImageCommentsState();
}

class _ImageCommentsState extends State<ImageComments> {
  CommentList comments;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      this.prefs = prefs;
    });

    Gallery()
        .getImageComments(this.widget.image.id, "top")
        .then((CommentList json) {
      setState(() {
        this.comments = json;
      });
    });
  }

  void createCommentUpload(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 200),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://i.imgur.com/user/" + prefs.getString("user_account_name") + "/avatar"
                                )
                            )
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(prefs.getString("user_account_name"), style: TextStyle(fontWeight: FontWeight.w600)),
                      )
                    ],
                  ),
                ),
                Container(
                  child: TextFormField(
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      color: Colors.lightBlueAccent,
                      icon: Icon(Icons.send),
                      onPressed: () {
                      }
                  )
                )
              ],
            )
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text("Comments"),
        ),
      ),
      body: (this.comments == null || prefs == null)
          ? Center(child: CircularProgressIndicator())
          : this.buildList(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_comment),
        onPressed: () => this.createCommentUpload(context)
      ),
    );
  }

  Widget buildList(BuildContext context) {
    return ListView.builder(
      itemCount: this.comments.list.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            child: Card(
                child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage("https://imgur.com/user/" +
                                this.comments.list[index].author +
                                "/avatar"))),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      this.comments.list[index].author,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 5, top: 3),
              alignment: Alignment.centerLeft,
              child: Text(this.comments.list[index].comment),
            ),
            Container(
              padding: EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                          Icons.thumb_up,
                          size: 15,
                          color: (this.comments.list[index].vote == "up") ? Colors.lightGreenAccent : Colors.grey
                      ),
                      onPressed: () {
                        CommentManager.Comment().voteComment(this.comments.list[index].id, "up").then((Map<String, dynamic> json) {
                          setState(() {
                            this.comments.list[index].vote = "up";
                          });
                        });
                      }
                  ),
                  Text(this.comments.list[index].ups.toString(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),),
                  IconButton(
                      icon: Icon(
                          Icons.thumb_down,
                          size: 15,
                          color: (this.comments.list[index].vote == "down") ? Colors.redAccent : Colors.grey
                      ),
                      onPressed: () {
                        CommentManager.Comment().voteComment(this.comments.list[index].id, "down").then((Map<String, dynamic> json) {
                          setState(() {
                            this.comments.list[index].vote = "down";
                          });
                        });
                      }
                  ),
                  Text(this.comments.list[index].downs.toString(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),),
                ],
              ),
            )
          ],
        )));
      },
    );
  }
}

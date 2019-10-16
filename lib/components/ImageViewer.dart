import 'package:flutter/material.dart';
import 'package:epicture/managers/imgur/Gallery.dart';
import 'package:epicture/models/GalleryImage.dart';
import 'package:epicture/managers/imgur/Image.dart' as ImgurImage;
import 'package:epicture/components/ImageComments.dart';

class ImageViewer extends StatefulWidget {
  final GalleryImage image;
  final bool canPopContext;
  final bool isFromUser;

  ImageViewer({
      Key key,
      @required this.image,
      @required this.canPopContext,
      @required this.isFromUser
  }) : super(key: key);

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {

  @override
  Widget build(BuildContext context) {
      if (this.widget.canPopContext == true) {
          return Scaffold(
	      appBar: PreferredSize(
		  preferredSize: Size.fromHeight(40),
		  child: AppBar(
		      backgroundColor: Colors.lightBlueAccent,
		      title: Text(this.widget.image.username),
		  ),
	      ),
	      body: createBody(context),
	  );
      }
      return createBody(context);
  }

  Widget createBody(BuildContext context) {
      if (this.widget.canPopContext == true) {
          return SingleChildScrollView(
	      child: Container(
		  child: Column(
		      children: <Widget>[
			  Container(
			      padding: EdgeInsets.all(5),
			      child: createPostHeader(context, this.widget.image)
			  ),
			  createPostImage(context, this.widget.image),
			  createPostActions(context, this.widget.image),
			  createPostComments(context, this.widget.image)
		      ],
		  ),
	      ),
	  );
      }
      return Card(
	  semanticContainer: true,
	  clipBehavior: Clip.antiAliasWithSaveLayer,
	  child: Container(
	      child: Column(
		  children: <Widget>[
		      Container(
			  padding: EdgeInsets.all(5),
			  child: createPostHeader(context, this.widget.image)),
		      createPostImage(context, this.widget.image),
		      createPostActions(context, this.widget.image),
		      createPostComments(context, this.widget.image)
		  ],
	      ),
	  ),
	  shape: RoundedRectangleBorder(
	      borderRadius: BorderRadius.circular(20.0),
	  ),
	  elevation: 7,
	  margin: EdgeInsets.all(10),
      );
  }

  Widget createPostHeader(BuildContext context, GalleryImage image) {
      if (this.widget.isFromUser == false) {
	  return Container(
	      child: Row(
		  mainAxisAlignment: MainAxisAlignment.start,
		  children: <Widget>[
		      Container(
			  padding: EdgeInsets.all(5),
			  child: Align(
			      alignment: Alignment.centerLeft,
			      child: Container(
				  width: 30.0,
				  height: 30.0,
				  decoration: BoxDecoration(
				      shape: BoxShape.circle,
				      image: DecorationImage(
					  fit: BoxFit.cover,
					  image: NetworkImage(
					      "https://imgur.com/user/" +
						  image.username + "/avatar"
					  )
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
	      )
	  );
      }
      return Container();
  }

  Widget createPostImage(BuildContext context, GalleryImage image) {
      if (this.widget.isFromUser == true) {
	  return Image.network(
	      "https://i.imgur.com/" +
		  image.id +
		  "." + ((image.imagesInfo == null) ? "jpg": image.imagesInfo[0].type.split('/')[1]),
	      fit: BoxFit.fill,
	  );
      }
      return Image.network(
	  "https://i.imgur.com/" +
	      image.cover +
	      "." +
	      image.imagesInfo[0].type.split('/')[1],
	  fit: BoxFit.fill,
      );
  }

  Widget createPostActions(BuildContext context, GalleryImage image) {
      if (this.widget.isFromUser == true) {
          return Container(
	      child: Row(
		  mainAxisAlignment: MainAxisAlignment.end,
		  children: <Widget>[
		      Container(
			  child: Text(
			      image.views.toString() + " views",
			      style: TextStyle(fontWeight: FontWeight.w600),
			  ),
		      )
		  ],
	      ),
	  );
      }
      return Container(
	  child: Row(
	      mainAxisAlignment: MainAxisAlignment.start,
	      children: <Widget>[
		  Container(
		      child: IconButton(
			  icon: Icon(Icons.thumb_up,
			      color: (image.vote != null && image.vote == "up")
				  ? Colors.greenAccent
				  : Colors.grey),
			  onPressed: () {
			      Gallery()
				  .voteImage(image.id, 'up')
				  .then((Map<String, dynamic> resp) {
				  setState(() {
				      image.vote = "up";
				  });
				  Scaffold.of(context).showSnackBar(SnackBar(
				      content: Text(
					  "You just liked " + image.username + "'s post !"),
				      backgroundColor: Colors.greenAccent,
				  ));
			      });
			  }),
		  ),
		  Container(
		      child: IconButton(
			  icon: Icon(Icons.thumb_down,
			      color: (image.vote != null && image.vote == "down")
				  ? Colors.redAccent
				  : Colors.grey),
			  onPressed: () {
			      Gallery()
				  .voteImage(image.id, 'down')
				  .then((Map<String, dynamic> resp) {
				  setState(() {
				      image.vote = "down";
				  });
				  Scaffold.of(context).showSnackBar(SnackBar(
				      content: Text(
					  "You just disliked " + image.username + "'s post !"),
				      backgroundColor: Colors.redAccent,
				  ));
			      });
			  }),
		  ),
		  Container(
		      child: IconButton(
			  icon: Icon(Icons.save_alt, color: Colors.lightBlueAccent),
			  onPressed: () {
			      ImgurImage.Image()
				  .favoriteImage(image)
				  .then((Map<String, dynamic> resp) {
				  Scaffold.of(context).showSnackBar(SnackBar(
				      content: Text("Image saved in favorites !"),
				      backgroundColor: Colors.lightBlueAccent,
				  ));
			      });
			  }),
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

  Widget createPostComment(BuildContext context, String user, String comment) {
      return Text.rich(TextSpan(children: <TextSpan>[
	  TextSpan(
	      text: user + "  ",
	      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11)),
	  TextSpan(text: comment, style: TextStyle(fontSize: 11))
      ]));
  }

  Widget createPostComments(BuildContext context, GalleryImage image) {
      if (this.widget.isFromUser == false) {
	  return Container(
	      padding: EdgeInsets.all(10),
	      child: Column(
		  children: <Widget>[
		      Container(
			  alignment: Alignment.centerLeft,
			  child: createPostComment(
			      context, image.username, image.title),
		      ),
		      Container(
			  alignment: Alignment.centerLeft,
			  child: FlatButton(
			      onPressed: () {
				  Navigator.push(
				      context,
				      MaterialPageRoute(
					  builder: (context) =>
					      ImageComments(image: image)));
			      },
			      textColor: Colors.grey,
			      splashColor: Colors.white,
			      highlightColor: Colors.white,
			      child: Text(
				  "See comments... (" +
				      image.comments.toString() + ")",
				  style: TextStyle(fontSize: 12),
			      )),
		      )
		  ],
	      )
	  );
      }
      return Container();
  }
}

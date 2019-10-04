import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(5),
                    child: createPostHeader(context)),
                createPostImage(context),
                createPostActions(context),
                createPostComments(context)
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

  Widget createPostHeader(BuildContext context) {
    return Row(
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
            "randompictureofficial",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }

  Widget createPostImage(BuildContext context) {
    return Image.network(
      'https://placeimg.com/640/480/any',
      fit: BoxFit.fill,
    );
  }

  Widget createPostActions(BuildContext context) {
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
              "1374 J'aime",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget createPostComments(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(10),
      child: Text.rich(TextSpan(children: <TextSpan>[
        TextSpan(
            text: "randompictureofficial  ",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11)),
        TextSpan(
            text: "Watch those guys walking... Amazing #grey",
            style: TextStyle(fontSize: 11))
      ])),
    );
  }
}

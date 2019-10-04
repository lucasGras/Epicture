import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  SearchView({Key key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          createSearchBar(context),
          createCardGrid(context)
        ],
      ),
    );
  }

  Widget createCardGrid(BuildContext context) {
    return Flexible(
      child: GridView.builder(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: 20,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return createResultCard(context);
          }
      )
    );
  }

  Widget createResultCard(BuildContext context) {
    return Container(
      child: Card(
        semanticContainer: true,
        child: GridTile(
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('https://placeimg.com/640/480/any'))),
          ),
        )
      ),
    );
  }

  Widget createSearchBar(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: new Icon(Icons.search, color: Colors.grey),
              hintText: "Search...",
              hintStyle: new TextStyle(color: Colors.grey)
          )
      ),
    );
  }
}
import 'package:flutter/material.dart';

class NewView extends StatefulWidget {
    NewView({Key key}) : super(key: key);

    @override
    _NewViewState createState() => _NewViewState();
}

class _NewViewState extends State<NewView> {

    @override
    Widget build(BuildContext context) {
        return Container(
            child: Text("NEW PHOTO"),
        );
    }
}

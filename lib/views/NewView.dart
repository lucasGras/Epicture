import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class NewView extends StatefulWidget {
    NewView({Key key}) : super(key: key);

    @override
    _NewViewState createState() => _NewViewState();
}

class _NewViewState extends State<NewView> {

    CameraDescription camera;

    void searchForCamera() async {
        dynamic cameras = await availableCameras();
        setState(() {
            this.camera = cameras.first;
        });
    }

    @override
    void initState() {
        super.initState();

        this.searchForCamera();
    }

    @override
    Widget build(BuildContext context) {
        if (this.camera == null) {
            return Container(
                child: Text("WAIT FOR PHOTO"),
            );
        } else {
            return Container(
                child: Text("NEW PHOTO"),
            );
        }
    }
}

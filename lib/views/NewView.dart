import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class NewView extends StatefulWidget {
    NewView({Key key}) : super(key: key);

    @override
    _NewViewState createState() => _NewViewState();
}

class _NewViewState extends State<NewView> {

    CameraDescription camera;
    CameraController cameraController;
    bool ready = false;

    void searchForCamera() async {
        dynamic cameras = await availableCameras();
        setState(() {
            this.camera = cameras.first;
            this.cameraController = CameraController(
                this.camera,
                ResolutionPreset.medium
            );
        });
        await this.cameraController.initialize();
        setState(() {
          this.ready = true;
        });
    }

    @override
    void initState() {
        super.initState();

        this.searchForCamera();
    }

    @override
    void dispose() {
        super.dispose();

        this.cameraController.dispose();
    }

    @override
    Widget build(BuildContext context) {
        if (this.camera == null || !this.ready) {
            return CircularProgressIndicator();
        } else {
            return Scaffold(
                body: CameraPreview(this.cameraController),
                floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.photo_camera),
                    onPressed: () async {
                        var tempDir = await getTemporaryDirectory();
                        var path = join(
                            tempDir.path,
                            '${DateTime.now()}.png'
                        );

                        await Directory(tempDir.path).create(recursive: true);

                        this.cameraController.takePicture(path);

                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => DisplayPictureScreen(imagePath: path)
                        ));
                    },
                ),
            );
        }
    }
}

class DisplayPictureScreen extends StatelessWidget {
    final String imagePath;

    const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: Text('Preview')),
            body: Image.file(File(imagePath)),
        );
    }
}

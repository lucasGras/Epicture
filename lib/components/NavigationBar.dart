import 'package:flutter/material.dart';
import 'package:epicture/views/HomeView.dart';
import 'package:epicture/views/SearchView.dart';
import 'package:epicture/views/ProfileView.dart';
import 'package:epicture/views/NewView.dart';
import 'package:image_picker/image_picker.dart';

class NavigationBarWidget extends StatefulWidget {
    NavigationBarWidget({Key key}) : super(key: key);

    @override
    _NavigationBarWidgetState createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
    int _selectedIndex = 0;
    List<Widget> _widgetOptions = <Widget>[
        HomeView(),
        SearchView(),
        ProfileView(),
    ];

    void _onItemTapped(int index) {
        setState(() {
            _selectedIndex = index;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                title: const Text('Epicture'),
            ),
            body: Center(
                child: _widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        title: Text('Home'),
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.search),
                        title: Text('Search'),
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        title: Text('Profile'),
                    ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.amber[800],
                unselectedItemColor: Colors.grey,
                onTap: _onItemTapped,
            ),
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.photo_camera),
                onPressed: () async {
                    var image = await ImagePicker.pickImage(source: ImageSource.camera);

                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => NewView(imageData: image)
                    ));
                },
            ),
        );
    }
}

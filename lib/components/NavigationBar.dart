import 'package:flutter/material.dart';
import 'package:epicture/views/HomeView.dart';
import 'package:epicture/views/SearchView.dart';
import 'package:epicture/views/ProfileView.dart';
import 'package:epicture/views/NewView.dart';
import 'package:epicture/views/Settings.dart';
import 'package:image_picker/image_picker.dart';

class NavigationBarWidget extends StatefulWidget {
    NavigationBarWidget({Key key}) : super(key: key);

    @override
    _NavigationBarWidgetState createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
    int selectedIndex = 0;
    List<String> pageNames = ["Epicture", "Search", "Profile", "Settings"];
    List<Widget> widgetOptions = <Widget>[
        HomeView(),
        SearchView(),
        ProfileView(),
        SettingsView()
    ];

    void _onItemTapped(int index) {
        setState(() {
            selectedIndex = index;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey.shade50,
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(40),
                child: AppBar(
                    backgroundColor: Colors.lightBlueAccent,
                    title: Text(pageNames[selectedIndex])
                ),
            ),
            body: Center(
                child: widgetOptions.elementAt(selectedIndex),
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
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings),
                        title: Text('Settings'),
                    ),
                ],
                currentIndex: selectedIndex,
                selectedItemColor: Colors.lightBlueAccent,
                unselectedItemColor: Colors.grey.shade700,
                onTap: _onItemTapped,
            ),
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.photo_camera),
                backgroundColor: Colors.lightBlueAccent,
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

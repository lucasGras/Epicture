import 'package:flutter/material.dart';
import 'package:epicture/views/HomeView.dart';
import 'package:epicture/views/SearchView.dart';
import 'package:epicture/views/ProfileView.dart';
import 'package:epicture/views/NewView.dart';
import 'package:image_picker/image_picker.dart';
import 'package:epicture/views/LoginView.dart';

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
        ProfileView()
    ];
    bool loggedOut = false;

    void _onItemTapped(int index) {
        setState(() {
            selectedIndex = index;
        });
    }

    Widget defaultAppBar(BuildContext context) {
        return PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: AppBar(
                backgroundColor: Colors.lightBlueAccent,
                title: Text(pageNames[selectedIndex]),
            ),
        );
    }

    Widget profileAppBar(BuildContext context) {
        return PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: AppBar(
                backgroundColor: Colors.lightBlueAccent,
                title: Text(pageNames[selectedIndex]),
                actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.forward, color: Colors.white),
                        onPressed: () {
                            setState(() {
                              this.loggedOut = true;
                            });
                        }
                    )
                ],
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        if (this.loggedOut == true) {
            return LoginView();
        }
        return Scaffold(
            backgroundColor: Colors.grey.shade50,
            resizeToAvoidBottomInset: false,
            appBar: (selectedIndex == 2) ? profileAppBar(context) : defaultAppBar(context),
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
                    )
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
                    var image = await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 50);

                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => NewView(imageData: image)
                    ));
                },
            ),
        );
    }
}

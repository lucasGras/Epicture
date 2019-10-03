import 'package:flutter/material.dart';
import 'package:epicture/components/NavigationBar.dart';

void main() => runApp(Epicture());

class Epicture extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Epicture',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NavigationBarWidget(),
    );
  }
}
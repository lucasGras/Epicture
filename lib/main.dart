import 'package:flutter/material.dart';
import 'package:epicture/views/LoginView.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(Epicture());

class Epicture extends StatelessWidget {

  Epicture() {
    SharedPreferences.setMockInitialValues({});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Epicture',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginView()
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final String clientId = "23f26b423ada9c1";
  final String responseType = "token";

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        url: "https://api.imgur.com/oauth2/authorize?client_id=" + clientId + "&response_type=" + responseType,
        appBar: AppBar(
          title: Text("Connexion"),
        )
    );
  }
}

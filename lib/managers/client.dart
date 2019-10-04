
import 'dart:io';
import 'package:http/http.dart';
import 'dart:convert';


class Client {
  HttpClient _client;
  String _header = "Bearer b7c3e1fcd5d8a3741840e7bd035785bfec72f543";
  String _request = "https://api.imgur.com/3/account/groupelucas";

  Client() {
    _client = new HttpClient();
    _client.findProxy = null;
  }

  closeConnection() {
      _client.close();
  }

  clientRequest() {
      _client.getUrl(Uri.parse(_request))
          .then((HttpClientRequest request) {
            request.headers.set("Authorization", _header);
              return request.close();
          })
          .then((HttpClientResponse response) {
              response.transform(Utf8Decoder()).forEach(print);

          });
      return("oui");
  }
}
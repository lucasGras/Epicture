
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';

class Client {
  HttpClient _client;
  String _header = "Bearer b7c3e1fcd5d8a3741840e7bd035785bfec72f543";

  Client() {
    _client = new HttpClient();
    _client.findProxy = null;
  }

  closeConnection() {
      _client.close();
  }

  clientRequest() {
      _client.getUrl(Uri.parse("https://api.imgur.com/3/account/groupelucas"))
          .then((HttpClientRequest request) {
            request.headers.set("Authorization", _header);
            print(request.contentLength);
              return request.close();
          })
          .then((HttpClientResponse response) {
            print(response.contentLength);
            response.transform(Utf8Decoder()).listen(print);
          });
      return("oui");
  }
}
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:epicture/models/AccountBase.dart';
import 'package:epicture/managers/imgur/Imgur.dart';

class Account extends Imgur {

    Future<AccountBase> getAccountBase(String username) async {

        var sharedPreferences = await SharedPreferences.getInstance();

        var response = await http.get(
            this.baseUrl + "/account/" + username,
            headers: {
                "Authorization": "Client-ID " + sharedPreferences.getString("account_id")
            }
        );

        if (response.statusCode == 200) {
            var json = convert.jsonDecode(response.body);
            return AccountBase.fromJson(json["data"]);
        } else {
            return null;
        }
    }
}
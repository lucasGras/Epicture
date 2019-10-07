import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:epicture/models/AccountBase.dart';
import 'package:epicture/managers/imgur/Imgur.dart';
import 'package:epicture/models/GalleryList.dart';

class Account extends Imgur {

    Future<AccountBase> getAccountBase() async {
        var sharedPreferences = await SharedPreferences.getInstance();

        var response = await http.get(
            this.baseUrl + "/account/" + sharedPreferences.getString("user_account_name"),
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

    Future<GalleryList> getAccountImages() async {
        var sharedPreferences = await SharedPreferences.getInstance();

        var response = await http.get(
            this.baseUrl + "/account/me/images",
            headers: {
                "Authorization": "Bearer " + sharedPreferences.getString("user_access_token")
            }
        );

        print(response.body);

        if (response.statusCode == 200) {
            var json = convert.jsonDecode(response.body);
            return GalleryList.fromJson(json);
        } else {
            return null;
        }
    }

    Future<int> getAccountPublicationsCount() async {
        var sharedPreferences = await SharedPreferences.getInstance();

        var response = await http.get(
            this.baseUrl + "/account/" + sharedPreferences.getString("user_account_name") + "/images/count",
            headers: {
                "Authorization": "Bearer " + sharedPreferences.getString("user_access_token")
            }
        );

        if (response.statusCode == 200) {
            var json = convert.jsonDecode(response.body);
            return json["data"];
        } else {
            return null;
        }
    }

    Future<Map<String, dynamic>> getAccountAlbums() async {
        var sharedPreferences = await SharedPreferences.getInstance();

        var response = await http.get(
            this.baseUrl + "/account/" + sharedPreferences.getString("user_account_name") + "/albums",
            headers: {
                "Authorization": "Client-ID " + sharedPreferences.getString("account_id")
            }
        );

        print("ALUBMS: ");
        print(response.body);

        if (response.statusCode == 200) {
            var json = convert.jsonDecode(response.body);
            return json;
        } else {
            return null;
        }
    }

    Future<Map<String, dynamic>> uploadImage(Map<String, dynamic> data) async {
        var sharedPreferences = await SharedPreferences.getInstance();

        List<int> imageBytes = data["image"].readAsBytesSync();
        String base64Image = convert.base64Encode(imageBytes);

        var response = await http.post(
            this.baseUrl + "/upload",
            headers: {
                "Authorization": "Bearer " + sharedPreferences.getString("user_access_token")
            },
            body: {
                "image": base64Image,
                "title": data["title"],
                "description": data["description"]
            }
        );

        if (response.statusCode == 200) {
            var json = convert.jsonDecode(response.body);
            print(json["data"]);
            return json["data"];
        } else {
            return null;
        }
    }

}
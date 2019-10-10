import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:epicture/models/AccountBase.dart';
import 'package:epicture/managers/imgur/Imgur.dart';
import 'package:epicture/models/GalleryList.dart';

class Account extends Imgur {

    /// Future<AccountBase> getAccountBase
    /// curl --location --request GET "https://api.imgur.com/3/account/{{username}}" \
    ///  --header "Authorization: Client-ID {{clientId}}"
    /// AccountBase Serializable
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

    /// Future<GalleryList> getAccountImages
    /// curl --location --request GET "https://api.imgur.com/3/account/me/images" \
    ///  --header "Authorization: Bearer {{accessToken}}"
    /// GalleryList Serializable
    Future<GalleryList> getAccountImages() async {
        var sharedPreferences = await SharedPreferences.getInstance();

        var response = await http.get(
            this.baseUrl + "/account/me/images",
            headers: {
                "Authorization": "Bearer " + sharedPreferences.getString("user_access_token")
            }
        );

        if (response.statusCode == 200) {
            var json = convert.jsonDecode(response.body);
            return GalleryList.fromJson(json);
        } else {
            return null;
        }
    }

    /// Future<int> getAccountPublicationsCount
    /// curl --location --request GET "https://api.imgur.com/3/account/{{username}}/images/count" \
    ///  --header "Authorization: Bearer {{accessToken}}"
    /// int
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

    /// Future<GalleryList> getGalleryFavorites
    ///curl --location --request GET "https://api.imgur.com/3/account/{{username}}/
    /// gallery_favorites/{{page}}/{{favoritesSort}}" \
    ///  --header "Authorization: Client-ID {{clientId}}"
    ///  GalleryList Serializable
    Future<GalleryList> getGalleryFavorites() async {
        var sharedPreferences = await SharedPreferences.getInstance();

        var response = await http.get(
            this.baseUrl + "/account/" + sharedPreferences.getString("user_account_name")
                + "/favorites",
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

    Future<void> logout() async {
        var sharedPreferences = await SharedPreferences.getInstance();

        await http.post(
            this.baseImgurUrl + "/logout?client_id=" + sharedPreferences.getString("account_id")
        );
        
        return;
    }
}
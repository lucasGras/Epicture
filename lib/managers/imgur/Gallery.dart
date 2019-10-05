import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:epicture/managers/imgur/Imgur.dart';
import 'package:epicture/models/GalleryList.dart';

class Gallery extends Imgur {

    Future<GalleryList> getGallery(Map<String, String> requestKeys, Map<String, bool> queries) async {

        var sharedPreferences = await SharedPreferences.getInstance();

        var url =  requestKeys["section"] + "/" + requestKeys["sort"]
            + "/" + requestKeys["window"] + "/" + requestKeys["page"];

        var queryUrl = "?showViral=" + queries["showViral"].toString()
            + "&mature=" + queries["showMature"].toString()
            + "&album_previews=" + queries["albumPreviews"].toString();

        var response = await http.get(
            this.baseUrl + "/gallery/" + url + queryUrl,
            headers: {
                "Authorization": "Client-ID " + sharedPreferences.getString("account_id")
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

    Future<GalleryList> getGalleryResearch(String search, String sort, String window) async {
        var sharedPreferences = await SharedPreferences.getInstance();

        var url =  "/" + sort + "/" + window + "/1";
        var queryUrl = "?q=" + search;

        var response = await http.get(
            this.baseUrl + "/gallery/search" + url + queryUrl,
            headers: {
                "Authorization": "Client-ID " + sharedPreferences.getString("account_id")
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

    Future<Map<String, dynamic>> getGalleryImageInfo(String imageHash) {

    }
}
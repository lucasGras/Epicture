## Managers - Serialization

### Example: GET Account Base

Let's see how the managers are working for a request to the Imgur API

    https://api.imgur.com/3/account/{{username}}

    curl --location --request GET "https://api.imgur.com/3/account/{{username}}" \
      --header "Authorization: Client-ID {{clientId}}"
      
The request is using the GET method, the route needs the username, and the clientID header.

We can add a method in the corresponding class, here **Account** because the main endpoint is `Account`.
The code will look the same for every request, you can refer to this sample:

```dart
Future<AccountBase> func() async {
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
```

- First we get the instance of sharedPreference in order to get user information (cache storage)
- Then we use http to process request (GET, POST, DEL, PUT, ...)
- Don't forget to change the URL (**this.baseurl** come from parent Imgur Class)
- Don't forget to put needed headers (ClientID, Bearer, ...)
- Process error handling, and return the result using a **Model Serialization**

> **All method must return a Future, so it's possible to write clean asynchronous front-end implementations.**

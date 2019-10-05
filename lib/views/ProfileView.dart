import 'package:flutter/material.dart';
import 'package:epicture/models/AccountBase.dart';
import 'package:epicture/managers/imgur/Account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
    ProfileView({Key key}) : super(key: key);

    @override
    _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
    AccountBase accountBase;

    _ProfileViewState() {
        SharedPreferences.getInstance().then((SharedPreferences prefs) {
            Account().getAccountBase(prefs.getString("user_account_name")).then((AccountBase resp) {
                print(resp.toJson());
                setState(() {
                    this.accountBase = resp;
                });
            });
        });
    }

    @override
    Widget build(BuildContext context) {
        if (this.accountBase == null) {
            return CircularProgressIndicator();
        } else {
            return Container(
                child: Column(
                    children: <Widget>[
                        createProfileHeader(context),
                        createProfileAlbum(context)
                    ],
                ),
            );
        }
    }

    Widget createResultCard(BuildContext context) {
        return Container(
            child: Card(
                semanticContainer: true,
                child: GridTile(
                    child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://placeimg.com/640/480/any'))),
                    ),
                )
            ),
        );
    }

    Widget createProfileAlbum(BuildContext context) {
        return Flexible(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: 20,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                    return createResultCard(context);
                }
            ),
        );
    }

    Widget createProfileHeader(BuildContext context) {
        return Container(
            child: Card(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        children: <Widget>[
                            Container(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                        createProfilePicture(context),
                                        createProfileStatisticsComments(context),
                                        createProfileStatisticsGrades(context)
                                    ],
                                )
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                    (this.accountBase.bio == null) ? "Aucune biographie" : this.accountBase.bio,
                                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                                ),
                            )
                        ],
                    )
            )
        )
        );
    }

    Widget createProfilePicture(BuildContext context) {
      return Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage('https://placeimg.com/640/480/any')
                      )
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 5),
              child: Text(
                this.accountBase.name,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12),
              ),
            )
          ],
        ),
      );
    }

    Widget createProfileStatisticsComments(BuildContext context) {
      return Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Icon(
                  Icons.mode_comment,
                  color: Colors.blueAccent),
            ),
            Container(
              child: Text("32"),
            )
          ],
        ),
      );
    }

    Widget createProfileStatisticsGrades(BuildContext context) {
      return Container(
        margin: EdgeInsets.only(
            right: MediaQuery.of(context).size.width / 10),
        child: Column(
          children: <Widget>[
            Container(
              child: Icon(
                  Icons.grade,
                  color: Colors.blueAccent),
            ),
            Container(
              child: Text(this.accountBase.reputation.toString()),
            )
          ],
        ),
      );
    }
}

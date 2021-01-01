import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagram_clone/services/auth.dart';

class HomeFeed extends StatefulWidget {
  @override
  _HomeFeedState createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  final AuthenticationService _authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
          child: Text(
            "Instagram Clone",
            style: TextStyle(
              fontFamily: "Billabong",
              fontSize: 30.0,
            ),
          ),
        ),
        // backgroundColor: Theme.of(context).primaryColor,
        elevation: 1.0,
        actions: [
          IconButton(
            icon: Icon(
              AntDesign.search1,
              color: Theme.of(context).iconTheme.color,
              size: 30.0,
            ),
            onPressed: () => print("search button"),
          ),
          IconButton(
            icon: Icon(
              Feather.send,
              color: Theme.of(context).iconTheme.color,
              size: 30.0,
            ),
            onPressed: () => print("inbox button"),
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text("Log Out"),
            onPressed: () async {
              dynamic result = await _authService.signOut();
              if (result == null) {
                print("Error in logging out");
              }
            },
          ),
        ),
      ),
    );
  }
}

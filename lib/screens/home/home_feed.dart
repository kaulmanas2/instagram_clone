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
        title: IconButton(
          icon: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
            child: Image.asset("assets/images/instagram_typography.png"),
          ),
          onPressed: () => print("Go to top"),
          iconSize: 120.0,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(
              AntDesign.search1,
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () => print("search button"),
          ),
          IconButton(
            icon: Icon(
              FontAwesome5Brands.facebook_messenger,
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () => print("inbox button"),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Divider(height: 1.0, color: Colors.grey),

            Container(
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
            Text(_authService.userEmail),
          ],
        ),
      ),
    );
  }
}

/*
    return Center(
      child: Column(
        children: [
          Container(
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
          Text(_authService.userEmail),
        ],
      ),
    );
*/

/*
    body: Container(
      color: Colors.white,
      child: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Divider(height: 1.0, color: Colors.black),
            HomeFeed(),
            Container(
              child: Column(
                children: [
                  Divider(height: 1.0, color: Colors.black),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("Bottom Bar"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
*/
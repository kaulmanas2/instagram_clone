import 'package:flutter/material.dart';
import 'package:instagram_clone/services/auth.dart';

class HomeFeed extends StatefulWidget {
  @override
  _HomeFeedState createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {

  final AuthenticationService _authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Hello"),
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
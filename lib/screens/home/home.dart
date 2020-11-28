import 'package:flutter/material.dart';
import 'package:instagram_clone/services/auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final AuthenticationService _authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
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
        ),
      ),
    );
  }
}

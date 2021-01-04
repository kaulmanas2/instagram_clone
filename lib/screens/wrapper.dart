import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/posts.dart';
import 'package:instagram_clone/screens/authentication/login_selection.dart';
import 'package:instagram_clone/screens/home.dart';
import 'package:instagram_clone/services/auth.dart';
import 'package:instagram_clone/services/database_service.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = AuthenticationService();

    final user = Provider.of<User>(context);

    if (user != null) {
      print("Data for the user changed => $user");
      return MultiProvider(
        providers: [
          StreamProvider<DocumentSnapshot>.value(
            value: DatabaseService(uid: _auth.uid).personalUserData,
          ),
          StreamProvider<List<Posts>>.value(
            value: DatabaseService(uid: _auth.uid).userPosts,
          ),
        ],
        child: HomePage(),
      );
    } else {
      print("Data for the user changed => $user");
      return LoginSelection();
    }
  }
}

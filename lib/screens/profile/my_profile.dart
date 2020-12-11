import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagram_clone/services/auth.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  final AuthenticationService _authService = AuthenticationService();

  List<String> posts = [
    "https://images.pexels.com/photos/2273580/pexels-photo-2273580.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/5845730/pexels-photo-5845730.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/4913466/pexels-photo-4913466.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/5845682/pexels-photo-5845682.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/2273580/pexels-photo-2273580.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/5845730/pexels-photo-5845730.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/4913466/pexels-photo-4913466.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/5845682/pexels-photo-5845682.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/2273580/pexels-photo-2273580.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/5845730/pexels-photo-5845730.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/4913466/pexels-photo-4913466.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/5845682/pexels-photo-5845682.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Feather.lock, color: Colors.black),
        title: Text(
          "test_profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(
              Ionicons.ios_add,
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () => print("search button"),
          ),
          IconButton(
            icon: Icon(
              FontAwesome.bars,
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () async {
              dynamic result = await _authService.signOut();
              if (result == null) {
                print("Error in logging out");
              }
            }
          ),
        ],
      ),

      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage("https://images.pexels.com/photos/1933873/pexels-photo-1933873.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                    radius: 40.0,
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                          child: Text(
                            "${posts.length}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text("Posts"),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                          child: Text(
                            "172",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text("Followers"),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                          child: Text(
                            "163",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text("Following"),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(_authService.userEmail)
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                child: Text("Bio")
            ),

            Container(
              padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
              height: 35.0,
              width: double.infinity,
              child: OutlineButton(
                child: Text(
                  "Edit Profile",
                  style: TextStyle(
                      color: Colors.black,
                  ),
                ),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                onPressed: () {
                  print("Edit Profile");
                },
              ),
            ),

            SizedBox(height: 10.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                children: posts.map((post) {
                  return Container(
                    padding: EdgeInsets.all(1.0),
                    // height: 120.0,
                    child: Image.network(post, fit: BoxFit.cover,),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      )
    );
  }
}

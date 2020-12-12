import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagram_clone/services/auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final AuthenticationService _authService = AuthenticationService();

  bool isGridActive = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Feather.lock, color: Colors.black, size: 20.0),
        title: Text(
          "test_profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),

      endDrawer: Drawer (
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text("test_profile"),
            ),
            ListTile(
              title: Text("Log out"),
              onTap: () async {
                dynamic result = await _authService.signOut();
                if (result == null) {
                  print("Error in logging out");
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
              child: Container(
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
                  ],
                ),
              ),
            ),
          ];
        },

        body: Container(
          alignment: Alignment.topCenter,
          color: Colors.white,
          padding: EdgeInsets.only(top: 25.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: IconButton(
                      icon: Icon(
                        Icons.grid_on,
                        color: isGridActive ? Colors.black : Colors.grey[600],
                      ),
                      onPressed: () {
                        setState(() => isGridActive = true);
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(
                        Icons.list,
                        color: isGridActive ? Colors.grey[600] : Colors.black,
                      ),
                      onPressed: () {
                        setState(() => isGridActive = false);
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: isGridActive ? gridPosts() : listPosts(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

Container gridPosts() {
  return Container(
    padding: EdgeInsets.only(top: 5.0),
    child: GridView.count(
      crossAxisCount: 3,
      children: posts.map((post) {
        return Container(
          padding: EdgeInsets.all(1.0),
          child: Image.network(post, fit: BoxFit.cover,),
        );
      }).toList(),
    ),
  );
}

Container listPosts() {
  return Container(
    padding: EdgeInsets.only(top: 5.0),
    child: ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(1.0),
          // height: 120.0,
          child: Image.network(posts[index], fit: BoxFit.cover, height: 500.0,),
        );
      },
    ),
  );
}
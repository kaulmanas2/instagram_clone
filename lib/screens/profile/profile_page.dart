import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagram_clone/models/posts.dart';
import 'package:instagram_clone/screens/profile/edit_profile.dart';
import 'package:instagram_clone/services/auth.dart';
import 'package:instagram_clone/services/database_service.dart';
import 'package:instagram_clone/shared/constants.dart';
import 'package:instagram_clone/shared/loading.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final AuthenticationService _authService = AuthenticationService();

  bool isGridActive = true;

  DocumentSnapshot personalUserDataSnapshot;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: DatabaseService(uid: _authService.uid).personalUserData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          personalUserDataSnapshot = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              leading: Icon(
                  Feather.lock, color: Colors.black, size: 20.0),
              title: Text(
                personalUserDataSnapshot.data()["username"] ?? "error",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 1.0,
              iconTheme: IconThemeData(color: Colors.black),
            ),

            endDrawer: Drawer(
              child: Container(
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      height: 65.0,
                      child: DrawerHeader(
                        child: Text(
                          personalUserDataSnapshot.data()["username"] ?? "error",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
                              profilePicture(),
                              socialDetails(),
                            ],
                          ),
                          userDisplayName(),
                          userBio(),
                          editProfileButton(),
                        ],
                      ),
                    ),
                  ),
                ];
              },

              // body: tabBarView(), // use this to make UI look exactly like original instagram app
              body: postsTabBarView(),
            ),
          );
        }
        else {
          return Loading();
        }
      }
    );
  }

  Container profilePicture() {
    return Container(
      padding: EdgeInsets.all(25.0),
      child: CircleAvatar(
        backgroundImage: personalUserDataSnapshot.data()["profile_pic"] == ""
          ? NetworkImage(profilePicURL)
          : NetworkImage(personalUserDataSnapshot.data()["profile_pic"]),
        radius: 40.0,
      ),
    );
  }

  Container socialDetails() {
    return Container(
      child: Row(
        children: [
          noOfPosts(),
          noOfFollowers(),
          noOfFollowing(),
        ],
      ),
    );
  }

  Column noOfPosts() {
    final postsList = Provider.of<List<Posts>>(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          child: Text(
            "${postsList.length}",
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
    );
  }

  Column noOfFollowers() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          child: Text(
            "${personalUserDataSnapshot.data()["followers"].length}",
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
    );
  }

  Column noOfFollowing() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          child: Text(
            "${personalUserDataSnapshot.data()["following"].length}",
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
    );
  }

  Container userDisplayName() {
    if (_authService.displayName == null || _authService.displayName == "") {
      return Container();
    }
    else {
      return Container(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
        child: Text(
          _authService.displayName ?? "",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0
          ),
        ),
      );
    }
  }

  Container userBio() {
    if (personalUserDataSnapshot.data()["bio"] == null || personalUserDataSnapshot.data()["bio"] == "") {
      return Container();
    }
    else {
      return Container(
        padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
        child: Text(
          personalUserDataSnapshot.data()["bio"] ?? "",
        ),
      );
    }
  }

  Container editProfileButton() {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
      height: 65.0,
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
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
          setState(() {});
        },
      ),
    );
  }

  Container postsTabBarView() {
    return Container(
      alignment: Alignment.topCenter,
      color: Colors.white,
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
    );
  }

  Container gridPosts() {
    final postsList = Provider.of<List<Posts>>(context).reversed.toList();
    // print(postsList.runtimeType);
    if (postsList.isEmpty) {
      return Container(
        child: Center(
          child: Text(
            "No posts uploaded",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0
            ),
          ),
        ),
      );
    }
    else {
      return Container(
        color: Colors.white,
        child: GridView.count(
          crossAxisCount: 3,
          children: postsList.map((post) {
            return Container(
              padding: EdgeInsets.all(1.0),
              child: Image.network(post.downURL, fit: BoxFit.cover),
            );
          }).toList(),
        ),
      );
    }
  }

  Container listPosts() {
    final postsList = Provider.of<List<Posts>>(context).reversed.toList();
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: postsList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              listPostsTop(index, postsList),
              listPostsMid(index, postsList),
              listPostsBottom(index, postsList),
            ],
          );
        },
      ),
    );
  }

  Container listPostsTop(int index, List<Posts> postsList) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: personalUserDataSnapshot.data()["profile_pic"] == ""
                  ? NetworkImage(profilePicURL)
                  : NetworkImage(personalUserDataSnapshot.data()["profile_pic"]),
                // backgroundImage: NetworkImage(profilePicURL),
                radius: 15.0,
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      personalUserDataSnapshot.data()["username"],
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  postsList[index].location == ""
                  ? Container()
                  : Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      postsList[index].location,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            child: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () => print("More clicked"),
            ),
          ),
        ],
      ),
    );
  }

  Container listPostsMid(int index, List<Posts> postsList) {
    if (postsList.isEmpty) {
      return Container(child: Loading());
    }
    else {
      return Container(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(1.0),
        child: Image.network(
          postsList[index].downURL, fit: BoxFit.cover),
      );
    }
  }

  Container listPostsBottom(int index, List<Posts> postsList) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        AntDesign.hearto,
                        size: 25.0,
                      ),
                      onPressed: () => print("Like Post"),
                    ),
                    IconButton(
                      icon: Icon(
                        Octicons.comment,
                        size: 25.0,
                      ),
                      onPressed: () => print("Comment Post"),
                    ),
                    IconButton(
                      icon: Icon(
                        FontAwesome.send_o,
                        size: 25.0,
                      ),
                      onPressed: () => print("Send Post"),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: IconButton(
                  icon: Icon(Icons.save_alt),
                  onPressed: () => print("More clicked"),
                ),
              ),
            ],
          ),

          postsList[index].caption == ""
           ? Container()
           : Container(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  "${postsList[index].caption}",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )
            ),
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
            alignment: Alignment.centerLeft,
            child: Text(
              "${postsList[index].timestamp.day}/${postsList[index].timestamp.month}/${postsList[index].timestamp.year}",
              style: TextStyle(
                color: Colors.grey[700],
              ),
            )
          ),
        ],
      ),
    );
  }



  // // this tab bar looks exactly the same but hinders in nested scrolling
  // DefaultTabController tabBarView() {
  //   return DefaultTabController(
  //       length: 2,
  //       initialIndex: 0,
  //       child: Scaffold(
  //         appBar: AppBar(
  //           elevation: 0.0,
  //           backgroundColor: Colors.white,
  //           flexibleSpace: TabBar(
  //             indicatorColor: Colors.black,
  //             tabs: [
  //               Tab(
  //                 icon: Icon(
  //                   Icons.grid_on,
  //                   color: Colors.black,
  //                 ),
  //               ),
  //               Tab(
  //                 icon: Icon(
  //                   Icons.list,
  //                   color: Colors.black,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         body: TabBarView(
  //           children: [
  //             gridPosts(postsList),
  //             listPosts(),
  //           ],
  //         ),
  //       )
  //   );
  // }
}
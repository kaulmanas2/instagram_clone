import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagram_clone/models/posts.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/screens/profile/edit_profile.dart';
import 'package:instagram_clone/screens/profile/grid_posts.dart';
import 'package:instagram_clone/screens/profile/list_posts.dart';
import 'package:instagram_clone/services/auth.dart';
import 'package:instagram_clone/services/database_service.dart';
import 'package:instagram_clone/shared/loading.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthenticationService _authService = AuthenticationService();

  bool isGridActive = true;

  UserData userData;
  DocumentSnapshot dataSnapshot;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: DatabaseService(uid: _authService.uid).personalUserData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          dataSnapshot = snapshot.data;

          userData = UserData(
              username: dataSnapshot.data()["username"] ?? "",
              profile_pic: dataSnapshot.data()["profile_pic"] ?? "",
              bio: dataSnapshot.data()["bio"] ?? "",
              followers: dataSnapshot.data()["followers"] ?? [],
              following: dataSnapshot.data()["following"] ?? []);

          return Scaffold(
            appBar: AppBar(
              leading: Icon(
                Feather.lock,
                size: 20.0,
              ),
              title: Text(userData.username ?? "error"),
              elevation: 1.0,
            ),
            endDrawer: Drawer(
              child: Container(
                // color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      height: 65.0,
                      child: DrawerHeader(
                        child: Text(
                          userData.username ?? "error",
                          style: TextStyle(
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
              headerSliverBuilder: (context, value) => [
                SliverToBoxAdapter(
                  child: Container(
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
              ],

              // use this to make UI look exactly like original instagram app
              // this has issues with sliver when scrolling
              // body: tabBarView(userData),

              // use this to make the UI functional
              body: postsTabBarView(userData),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }

  Container profilePicture() {
    return Container(
      padding: EdgeInsets.all(25.0),
      child: CachedNetworkImage(
        imageUrl: userData.profile_pic,
        imageBuilder: (context, imageProvider) => CircleAvatar(
          backgroundImage: imageProvider,
          radius: 40.0,
        ),
        placeholder: (context, url) => CircleAvatar(
          backgroundImage: AssetImage("assets/images/no_profile_pic.png"),
          radius: 40.0,
        ),
        errorWidget: (context, url, error) => CircleAvatar(
          backgroundImage: AssetImage("assets/images/no_profile_pic.png"),
          radius: 40.0,
        ),
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
    final postsList = Provider.of<List<Posts>>(context) ?? [];
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 5.0,
          ),
          child: Text(
            "${postsList.length}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
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
          padding: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 5.0,
          ),
          child: Text(
            "${userData.followers.length}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
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
          padding: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 5.0,
          ),
          child: Text(
            "${userData.following.length}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
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
    } else {
      return Container(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
        child: Text(
          _authService.displayName ?? "",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
      );
    }
  }

  Container userBio() {
    if (userData.bio == null || userData.bio == "") {
      return Container();
    } else {
      return Container(
        padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
        child: Text(
          userData.bio ?? "",
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
          style: TextStyle(),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (context) => EditProfile()));
          setState(() {});
        },
      ),
    );
  }

  Container postsTabBarView(UserData userData) {
    final postsList = Provider.of<List<Posts>>(context) ?? [];

    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.grid_on,
                    color: isGridActive
                        ? Theme.of(context).iconTheme.color
                        : Colors.grey[600],
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
                    color: isGridActive
                        ? Colors.grey[600]
                        : Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () {
                    setState(() => isGridActive = false);
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: isGridActive
                ? GridPosts(
                    postsList: postsList,
                  )
                : ListPosts(
                    userData: userData,
                    postsList: postsList,
                  ),
          ),
        ],
      ),
    );
  }

  // this tab bar looks exactly the same but hinders in scrolling with sliver
  // the silver above does not collapse when grid/list view scrolled
  DefaultTabController tabBarView(UserData userData) {
    final postsList = Provider.of<List<Posts>>(context) ?? [];

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          flexibleSpace: TabBar(
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridPosts(
              postsList: postsList.reversed.toList(),
            ),
            ListPosts(
              userData: userData,
              postsList: postsList.reversed.toList(),
            ),
          ],
        ),
      ),
    );
  }
}

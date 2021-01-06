import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/screens/home/home_feed.dart';
import 'package:instagram_clone/screens/post_upload/upload_post.dart';
import 'package:instagram_clone/screens/profile/profile_page.dart';
import 'package:instagram_clone/services/auth.dart';
import 'package:instagram_clone/services/database_service.dart';
import 'package:instagram_clone/shared/loading.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthenticationService _authService = AuthenticationService();
  GlobalKey bottomNavBarKey = GlobalKey();

  UserData userData;
  DocumentSnapshot dataSnapshot;

  int currentIndex = 0;

  // var tabBarContent = <Widget>[
  //
  // ];

  // TODO: can use Provider -> value notifier to switch Bottom Navigation Page after post upload is complete
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: DatabaseService(uid: _authService.uid).personalUserData,
      builder: (context, snapshot) {
        print("Stream Error ======> ${snapshot.error}");
        if (snapshot.hasData) {
          dataSnapshot = snapshot.data;

          userData = UserData(
              username: dataSnapshot.data()["username"] ?? "",
              profile_pic: dataSnapshot.data()["profile_pic"] ?? "",
              bio: dataSnapshot.data()["bio"] ?? "",
              followers: dataSnapshot.data()["followers"] ?? [],
              following: dataSnapshot.data()["following"] ?? []);

          print("DATA ====> got data from snapshot <==== DATA");

          return SafeArea(
            child: Scaffold(
              body: navBarBody(),
              bottomNavigationBar: navBarFooter(),
              /*
              body: Container(
                child: tabBarContent[currentIndex],
              ),
              bottomNavigationBar: BottomNavigationBar(
                key: bottomNavBarKey,
                currentIndex: currentIndex,
                items: [
                  BottomNavigationBarItem(
                    icon:
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon:
                    label: "Reels",
                  ),
                  BottomNavigationBarItem(
                    icon: ,
                    label: "Upload",
                  ),
                  BottomNavigationBarItem(
                    icon: ,
                    label: "Likes",
                  ),
                  BottomNavigationBarItem(
                    icon: ,
                    label: "Profile",
                  ),
                ],
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                elevation: 5.0,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                    // _currentPage = index;
                  });
                },
              ),
              */
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }

  Widget navBarBody() {
    return IndexedStack(
      index: currentIndex,
      children: [
        HomeFeed(),
        Center(child: Text('Reels feature is under development')),
        UploadPost(),
        Center(child: Text('Likes feature is under development')),
        ProfilePage(),
      ],
    );
  }

  Widget navBarFooter() {
    return Container(
      width: double.infinity,
      height: 55.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () => changePage(0),
            child: Icon(
              AntDesign.home,
              size: 25.0,
            ),
          ),
          InkWell(
            onTap: () => changePage(1),
            child: Icon(
              Icons.video_collection_outlined,
            ),
          ),
          InkWell(
            onTap: () => changePage(2),
            child: Icon(
              Ionicons.ios_add_circle_outline,
              size: 30.0,
            ),
          ),
          InkWell(
            onTap: () => changePage(3),
            child: Icon(
              AntDesign.hearto,
            ),
          ),
          InkWell(
            onTap: () => changePage(4),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.circle,
                  size: 40,
                  color: currentIndex == 4
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).canvasColor,
                ),
                CachedNetworkImage(
                  imageUrl: userData.profile_pic,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    backgroundImage: imageProvider,
                    radius: 15.0,
                  ),
                  placeholder: (context, url) => CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/no_profile_pic.png"),
                    radius: 15.0,
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/no_profile_pic.png"),
                    radius: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}

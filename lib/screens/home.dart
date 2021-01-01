import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagram_clone/screens/home/home_feed.dart';
import 'package:instagram_clone/screens/post_upload/upload_post.dart';
import 'package:instagram_clone/screens/profile/profile_page.dart';
import 'package:instagram_clone/services/auth.dart';
import 'package:instagram_clone/services/database_service.dart';
import 'package:instagram_clone/shared/constants.dart';
import 'package:instagram_clone/shared/loading.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final AuthenticationService _authService = AuthenticationService();
  GlobalKey bottomNavBarKey = GlobalKey();
  DocumentSnapshot dataSnapshot;

  int currentIndex = 0;
  int _currentPage = 0;

  var tabBarContent = <Widget>[
    HomeFeed(),
    Text('Index 1: Reels'),
    UploadPost(),
    Text('Index 3: Likes'),
    ProfilePage(), // Text('Index 4: Profile'),
  ];

  // TODO: can use Provider -> value notifier to switch Bottom Navigation Page after post upload is complete
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: DatabaseService(uid: _authService.uid).personalUserData,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          dataSnapshot = snapshot.data;
          return SafeArea(
            child: Scaffold(
              body: Container(
                color: Colors.white,
                child: tabBarContent[currentIndex],
              ),
              bottomNavigationBar: BottomNavigationBar(
                key: bottomNavBarKey,
                backgroundColor: Colors.white,
                currentIndex: currentIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        AntDesign.home,
                        size: 25.0,
                        color: (_currentPage == 0) ? Colors.black : Colors.grey[600],
                      ),
                      label: "Home"
                  ),

                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.video_collection_outlined,
                        color: (_currentPage == 1) ? Colors.black : Colors
                            .grey[600],
                      ),
                      label: "Reels"
                  ),

                  BottomNavigationBarItem(
                      icon: Icon(
                        Ionicons.ios_add_circle_outline,
                        size: 30.0,
                        color: (_currentPage == 2) ? Colors.black : Colors
                            .grey[600],
                      ),
                      label: "Upload"
                  ),

                  BottomNavigationBarItem(
                      icon: Icon(
                        AntDesign.hearto,
                        color: (_currentPage == 3) ? Colors.black : Colors
                            .grey[600],
                      ),
                      label: "Likes"
                  ),

                  BottomNavigationBarItem(
                    icon: CachedNetworkImage(
                      imageUrl: dataSnapshot.data()["profile_pic"],
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: imageProvider,
                        radius: 15.0,
                      ),
                      placeholder: (context, url) => CircleAvatar(
                        backgroundImage: AssetImage("assets/images/no_profile_pic.png"),
                        radius: 15.0,
                      ),
                      errorWidget: (context, url, error) => CircleAvatar(
                        backgroundImage: AssetImage("assets/images/no_profile_pic.png"),
                        radius: 15.0,
                      ),
                    ),
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
                    _currentPage = index;
                  });
                },
              ),
            ),
          );
        }
        else {
          return Loading();
        }
      }
    );
  }
}

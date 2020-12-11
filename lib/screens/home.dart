import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagram_clone/screens/home/home_feed.dart';
import 'package:instagram_clone/screens/profile/my_profile.dart';
import 'package:instagram_clone/services/auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  var tabBarContent = <Widget>[
    HomeFeed(),
    Text('Index 1: Reels'),
    Text('Index 2: Add Photo'),
    Text('Index 3: Likes'),
    MyProfile(),
  ];

  static const tabs = <BottomNavigationBarItem> [
    // BottomNavigationBarItem(icon: Icon(Foundation.home, color: Colors.black), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.video_collection_outlined, color: Colors.black), label: "Reels"),
    // BottomNavigationBarItem(icon: Icon(Ionicons.ios_add_circle_outline, color: Colors.black), label: "Add Pic"),
    BottomNavigationBarItem(icon: Icon(Icons.add_a_photo, color: Colors.black), label: "Add Pic"),
    // BottomNavigationBarItem(icon: Icon(AntDesign.hearto, color: Colors.black), label: "Liked"),
    BottomNavigationBarItem(icon: Icon(Icons.ac_unit_rounded, color: Colors.black), label: "Liked"),
    BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.black), label: "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: tabBarContent[currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: tabs,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0.0,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

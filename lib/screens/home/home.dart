import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagram_clone/screens/home/home_feed.dart';
import 'package:instagram_clone/services/auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  static const tabBarContent = <Widget>[
    Text('Index 0: Home'),
    Text('Index 1: Reels'),
    Text('Index 2: Add Photo'),
    Text('Index 3: Likes'),
    Text('Index 4: Profile'),
  ];

  static const tabs = <BottomNavigationBarItem> [
    BottomNavigationBarItem(icon: Icon(Foundation.home, color: Colors.black), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.video_collection_outlined, color: Colors.black), label: "Reels"),
    BottomNavigationBarItem(icon: Icon(Ionicons.ios_add_circle_outline, color: Colors.black), label: "Add Pic"),
    BottomNavigationBarItem(icon: Icon(AntDesign.hearto, color: Colors.black), label: "Liked"),
    BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.black), label: "Profile"),
  ];

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: IconButton(
            icon: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
              child: Image.asset("assets/images/instagram_typography.png"),
            ),
            onPressed: () => print("Go to top"),
            iconSize: 120.0,
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: Icon(
                AntDesign.search1,
                color: Colors.black,
                size: 30.0,
              ),
              onPressed: () => print("search button"),
            ),
            IconButton(
              icon: Icon(
                FontAwesome5Brands.facebook_messenger,
                color: Colors.black,
                size: 30.0,
              ),
              onPressed: () => print("inbox button"),
            ),
          ],
        ),

        body: Container(
          color: Colors.white,
          child: tabBarContent[currentIndex],
        ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            items: tabs,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0.0,
            iconSize: 30.0,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}

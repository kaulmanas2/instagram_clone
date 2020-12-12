import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagram_clone/screens/home/home_feed.dart';
import 'package:instagram_clone/screens/profile/profile_page.dart';
import 'package:instagram_clone/services/auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;
  int _currentPage = 0;

  var tabBarContent = <Widget>[
    HomeFeed(), // Text('Index 0: Home'),
    Text('Index 1: Reels'),
    Text('Index 2: Add Photo'),
    Text('Index 3: Likes'),
    ProfilePage(), // Text('Index 4: Profile'),
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
          items: [
            // BottomNavigationBarItem(icon: Icon(Foundation.home, color: Colors.black), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(
                SimpleLineIcons.home,
                size: 20.0,
                color: (_currentPage == 0) ? Colors.black : Colors.grey[600],
              ),
              label: "Home"
            ),

            BottomNavigationBarItem(
              icon: Icon(
                Icons.video_collection_outlined,
                color: (_currentPage == 1) ? Colors.black : Colors.grey[600],
              ),
              label: "Reels"
            ),

            BottomNavigationBarItem(
              icon: Icon(
                Ionicons.ios_add_circle_outline,
                size: 30.0,
                color: (_currentPage == 2) ? Colors.black : Colors.grey[600],
              ),
              label: "Upload"
            ),

            BottomNavigationBarItem(
              icon: Icon(
                  AntDesign.hearto,
                color: (_currentPage == 3) ? Colors.black : Colors.grey[600],
              ),
              label: "Likes"
            ),

            BottomNavigationBarItem(
                icon: CircleAvatar(
                  backgroundImage: NetworkImage("https://images.pexels.com/photos/1933873/pexels-photo-1933873.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                  radius: 15.0,
                ),
                label: "Profile"
            ),
          ],
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0.0,
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
}
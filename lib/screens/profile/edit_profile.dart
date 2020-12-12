import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/services/auth.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final AuthenticationService _authService = AuthenticationService();

  String displayName;
  String username;
  String bio;

  void changeProfilePic(String displayName) {
    print("Change Profile Photo");
  }

  void changeProfileDetails() async {
    print("Change Name, Username, Bio");
    await _authService.setDisplayName(displayName);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black,
            size: 35.0
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(
                Icons.check,
                color: Colors.blue,
                size: 35.0
            ),
            onPressed: () => changeProfileDetails(),
          ),
        ],
      ),

      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage("https://images.pexels.com/photos/1933873/pexels-photo-1933873.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                    radius: 50.0,
                  ),
                ),
              ),

              Container(
                child: TextButton(
                  child : Text(
                    "Change Profile Photo",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blue,
                    ),
                  ),
                  onPressed: () => changeProfilePic("Test"),
                )
              ),

              Container(
                padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                height: 70.0,
                child: TextFormField(
                  initialValue: _authService.displayName ?? displayName,
                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                  onChanged: (val) {
                    displayName = val;
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                height: 70.0,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Username",
                  ),
                  onChanged: (_) {},
                ),
              ),

              Container(
                padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                height: 70.0,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Bio",
                  ),
                  onChanged: (_) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
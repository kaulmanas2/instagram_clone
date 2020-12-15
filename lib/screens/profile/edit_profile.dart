import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/services/auth.dart';
import 'package:instagram_clone/services/database_service.dart';
import 'package:instagram_clone/shared/loading.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final AuthenticationService _authService = AuthenticationService();

  String displayName;
  String username;
  String bio;

  bool isLoading = false;

  void changeProfilePic(String displayName) {
    print("Change Profile Photo");
  }

  // void changeProfileDetails() async {
  //   print("Change Name, Username, Bio");
  //   setState(() => isLoading = true);
  //   await _authService.setDisplayName(displayName);
  //   await DatabaseService(uid: _authService.uid).updateUserProfileData(username, bio);
  //   setState(() => isLoading = false);
  //   Navigator.pop(context, true);
  // }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Loading() : StreamBuilder<DocumentSnapshot>(
      stream: DatabaseService(uid: _authService.uid).personalUserData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DocumentSnapshot dataSnapshot = snapshot.data;
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
                  onPressed: () async {
                    print("Change Name, Username, Bio");
                    username = username ?? dataSnapshot.data()["username"];
                    bio = bio ?? dataSnapshot.data()["bio"];
                    // setState(() => isLoading = true);
                    await _authService.setDisplayName(displayName);
                    await DatabaseService(uid: _authService.uid).updateUserProfileData(username, bio);
                    Navigator.pop(context, true);
                    // setState(() => isLoading = false);
                  },
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
                          backgroundImage: NetworkImage(
                              "https://images.pexels.com/photos/1933873/pexels-photo-1933873.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                          radius: 50.0,
                        ),
                      ),
                    ),

                    Container(
                        child: TextButton(
                          child: Text(
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
                        initialValue: dataSnapshot.data()["username"],
                        decoration: InputDecoration(
                          labelText: "Username",
                        ),
                        onChanged: (val) {
                          username = val;
                        },
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      height: 70.0,
                      child: TextFormField(
                        initialValue: dataSnapshot.data()["bio"],
                        decoration: InputDecoration(
                          labelText: "Bio",
                        ),
                        onChanged: (val) {
                          bio = val;
                        },
                      ),
                    ),
                  ],
                ),
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
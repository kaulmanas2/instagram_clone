import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/services/auth.dart';
import 'package:instagram_clone/services/database_service.dart';
import 'package:instagram_clone/shared/loading.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final AuthenticationService _authService = AuthenticationService();

  UserData userData;
  DocumentSnapshot dataSnapshot;

  File chosenProfileImage;

  String displayName;
  String username;
  String bio;

  bool isLoading = false;
  bool isButtonEnabled = true;

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
                following: dataSnapshot.data()["following"] ?? []
            );

            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.clear,
                    size: 35.0,
                  ),
                  onPressed: isButtonEnabled
                      ? () {
                          Navigator.pop(context);
                        }
                      : null,
                ),
                title: Text(
                  "Edit Profile",
                  style: TextStyle(),
                ),
                // backgroundColor: Colors.white,
                elevation: 0.0,
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.check,
                      color: Colors.lightBlue[700],
                      size: 35.0,
                    ),
                    onPressed: isButtonEnabled
                        ? () async {
                            print("Change Name, Username, Bio");
                            username = username ?? userData.username;
                            bio = bio ?? userData.bio;
                            setState(() => isButtonEnabled = false);
                            await _authService.setDisplayName(displayName);
                            await DatabaseService(uid: _authService.uid)
                                .updateUserProfileData(username, bio);
                            Navigator.pop(context, true);
                          }
                        : null,
                  ),
                ],
              ),
              body: Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      profilePicture(),
                      changeProfilePicture(),
                      nameField(),
                      usernameField(),
                      bioField(),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }

  Container profilePicture() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Center(
        child: chosenProfileImage != null
            ? CircleAvatar(
                backgroundImage: FileImage(chosenProfileImage),
                radius: 50.0,
              )
            : CachedNetworkImage(
                imageUrl: userData.profile_pic,
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  backgroundImage: imageProvider,
                  radius: 80.0,
                ),
                placeholder: (context, url) => CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/no_profile_pic.png"),
                  radius: 80.0,
                ),
                errorWidget: (context, url, error) => CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/no_profile_pic.png"),
                  radius: 80.0,
                ),
              ),
      ),
    );
  }

  Container changeProfilePicture() {
    return Container(
      child: TextButton(
        child: Text(
          "Change Profile Photo",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.lightBlue[700],
          ),
        ),
        onPressed: () => _showChangePictureOptionsSheet(),
      ),
    );
  }

  Future updateProfilePic(File profilePic) async {
    try {
      await DatabaseService(uid: _authService.uid)
          .updateUserProfilePicture(profilePic);
      print("Image Uploaded");
    } catch (e) {
      print(e.toString());
    }
  }

  // Check for camera and gallery service
  Future chooseGalleryImage() async {
    try {
      dynamic img = await ImagePicker().getImage(source: ImageSource.gallery);
      setState(() {
        chosenProfileImage = File(img.path);
        print("Image Chosen from gallery");
        updateProfilePic(chosenProfileImage);
      });
    } catch (e) {
      print("ERROR HAS OCCURRED ${e.toString()}");
      setState(() {
        print("Image not Chosen");
      });
    }
    Navigator.pop(context);
  }

  Future chooseCameraImage() async {
    try {
      dynamic img = await ImagePicker().getImage(source: ImageSource.camera);
      setState(() {
        chosenProfileImage = File(img.path);
        print("Image Chosen from camera");
        updateProfilePic(chosenProfileImage);
      });
    } catch (e) {
      setState(() {
        print("Image not Choosen");
      });
    }
    Navigator.pop(context);
  }

  void _showChangePictureOptionsSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return changePicOptions();
      },
    );
  }

  Container changePicOptions() {
    return Container(
      child: Wrap(
        direction: Axis.vertical,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextButton(
              child: Text(
                "Upload Picture from Gallery",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18.0,
                ),
              ),
              onPressed: () async => await chooseGalleryImage(),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextButton(
              child: Text(
                "Capture New Picture from Camera",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18.0,
                ),
              ),
              onPressed: () async => await chooseCameraImage(),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextButton(
              child: Text(
                "Remove Current Picture",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18.0,
                ),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Container nameField() {
    return Container(
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
    );
  }

  Container usernameField() {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
      height: 70.0,
      child: TextFormField(
        initialValue: userData.username,
        decoration: InputDecoration(
          labelText: "Username",
        ),
        onChanged: (val) {
          username = val;
        },
      ),
    );
  }

  Container bioField() {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
      height: 70.0,
      child: TextFormField(
        initialValue: userData.bio,
        decoration: InputDecoration(
          labelText: "Bio",
        ),
        onChanged: (val) {
          bio = val;
        },
      ),
    );
  }
}

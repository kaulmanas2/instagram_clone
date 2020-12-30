import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/services/auth.dart';
import 'package:instagram_clone/services/database_service.dart';

class UploadPost extends StatefulWidget {
  @override
  _UploadPostState createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {

  final AuthenticationService _authService = AuthenticationService();

  File chosenPostImage;
  String picCaption = "";
  String picLocation = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
                Icons.clear,
                color: Colors.black,
                size: 35.0
            ),
            onPressed: () {
              setState(() {
                chosenPostImage = null;
                picLocation = "";
                picCaption = "";
              });
            }
          ),
          title: Text(
            "Upload new Post",
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
                  color: Colors.lightBlue[700],
                  size: 35.0
              ),
              onPressed: () async {
                if (chosenPostImage != null) {
                  var result = await DatabaseService(uid: _authService.uid).addNewPost(
                    chosenPostImage,
                    picCaption,
                    picLocation
                  );
                  if (result == null) {
                    setState(() {
                      chosenPostImage = null;
                      picLocation = "";
                      picCaption = "";
                    });
                  }
                }
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
                chosenPostImage == null
                  ? Container(
                    alignment: Alignment.topCenter,
                    color: Colors.white,
                    child: IconButton(
                      iconSize: 300.0,
                      icon: Icon(Icons.upload_rounded),
                      onPressed: () {
                        _showChangePictureOptionsSheet();
                      },
                    ),
                  )
                  : Container(
                      alignment: Alignment.topCenter,
                      color: Colors.white,
                      child: Image(
                        image: FileImage(chosenPostImage),
                        height: 300.0,
                        width: 300.0,
                        fit: BoxFit.cover,
                      ),
                    ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                  color: Colors.white,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.edit,
                      ),
                      labelText: "Write a caption...",
                    ),
                    onChanged: (val) {
                      picCaption = val;
                    },
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                  color: Colors.white,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                      ),
                      labelText: "Location",
                    ),
                    onChanged: (val) {
                      picLocation = val;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future openGallery() async {
    try {
      dynamic img = await ImagePicker().getImage(source: ImageSource.gallery);
      setState(() {
        chosenPostImage = File(img.path);
        print("Got the image from gallery");
      });
    }
    catch (e) {
      print("ERROR ${e.toString()}");
      setState(() {
        print("Image not chosen");
      });
    }
    Navigator.pop(context);
  }

  Future openCamera() async {
    try {
      dynamic img = await ImagePicker().getImage(source: ImageSource.camera);
      setState(() {
        chosenPostImage = File(img.path);
        print("Got the image from camera");
      });
    }
    catch (e) {
      print("ERROR");
      setState(() {
        print("Image not chosen");
      });
    }
    Navigator.pop(context);
  }

  void _showChangePictureOptionsSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return changePicOptions();
        }
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
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
              onPressed: () async => await openGallery(),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextButton(
              child: Text(
                "Capture New Picture from Camera",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
              onPressed: () async => await openCamera(),
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
}

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

  var _captionTextFormFieldController = TextEditingController();
  var _locationTextFormFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.clear,
                size: 35.0,
              ),
              onPressed: () {
                setState(() {
                  chosenPostImage = null;
                  picLocation = "";
                  picCaption = "";
                  _captionTextFormFieldController.clear();
                  _locationTextFormFieldController.clear();
                });
              }),
          title: Text("Upload new Post"),
          // backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.lightBlue[700],
                size: 35.0,
              ),
              onPressed: () async {
                if (chosenPostImage != null) {
                  var result = await DatabaseService(uid: _authService.uid)
                      .addNewPost(chosenPostImage, picCaption, picLocation);
                  if (result == null) {
                    setState(() {
                      chosenPostImage = null;
                      picLocation = "";
                      picCaption = "";
                      _captionTextFormFieldController.clear();
                      _locationTextFormFieldController.clear();
                    });
                  }
                }
              },
            ),
          ],
        ),
        body: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                chosenPostImage == null
                    ? Container(
                        alignment: Alignment.topCenter,
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
                        child: Image(
                          image: FileImage(chosenPostImage),
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 5.0,
                  ),
                  child: TextFormField(
                    controller: _captionTextFormFieldController,
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 5.0,
                  ),
                  child: TextFormField(
                    controller: _locationTextFormFieldController,
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
    } catch (e) {
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
    } catch (e) {
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
        });
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
              onPressed: () async => await openGallery(),
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

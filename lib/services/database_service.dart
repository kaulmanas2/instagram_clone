import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userProfilesCollection = FirebaseFirestore.instance.collection("user_profiles");
  final CollectionReference userPostsCollection = FirebaseFirestore.instance.collection("user_posts");

  Future setUserProfileData(String username) async {
    return await userProfilesCollection.doc(uid).set({
      "username": username,
      "profile_pic" : "",
      "bio": "",
      "followers" : new List(),
      "following" : new List(),
    });
  }

  Future updateUserProfilePicture(File profilePic) async {
    try {
      Reference ref = FirebaseStorage.instance.ref(uid).child("profile_pic");
      UploadTask uploadTask = ref.putFile(profilePic);
      uploadTask.whenComplete(() async {
        String downURL = await uploadTask.snapshot.ref.getDownloadURL();
        return await userProfilesCollection.doc(uid).update({
          "profile_pic" : downURL
        });
      });
    }
    catch(e) {
      print(e.toString());
    }
  }
  
  Future addNewPost(File post, String caption, String location) async {
    try {
      var uuid = Uuid().v1();
      Reference ref = FirebaseStorage.instance.ref(uid).child("post_$uuid");
      UploadTask uploadTask = ref.putFile(post);
      uploadTask.whenComplete(() async {
        String downURL = await uploadTask.snapshot.ref.getDownloadURL();
        return await userPostsCollection.doc(uid).collection("posts").add({
          "post_url": downURL,
          "caption": caption,
          "location": location,
          "timestamp": DateTime.now()
        });
      });
      print("Image Uploaded");
    }
    catch (e) {
      print(e.toString());
    }
  }

  Future updateUserProfileData(String username, String bio) async {
    return await userProfilesCollection.doc(uid).update({
      "username" : username,
      "bio" : bio,
    });
  }

  Future updateUserSocialData(String followers, String following) async {
    return await userProfilesCollection.doc(uid).update({
      "followers" : int.parse(followers),
      "following" : int.parse(following),
    });
  }

  Stream<DocumentSnapshot> get personalUserData {
    return userProfilesCollection.doc(uid).snapshots();
  }
}
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userProfilesCollection = FirebaseFirestore.instance.collection("user_profiles");

  Future setUserProfileData(String username) async {
    return await userProfilesCollection.doc(uid).set({
      "username": username,
      "profile_pic" : "",
      "bio": "",
      "posts" : 0,
      "followers" : 0,
      "following" : 0,
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

      // String downURL = await (await uploadTask.onComplete).ref.getDownloadURL();
    }
    catch(e) {
      print(e.toString());
    }
  }

  Future updateUserProfileData(String username, String bio) async {
    return await userProfilesCollection.doc(uid).update({
      "username" : username,
      "bio" : bio,
    });
  }

  Future updateUserSocalData(String followers, String following) async {
    return await userProfilesCollection.doc(uid).update({
      "followers" : int.parse(followers),
      "following" : int.parse(following),
    });
  }

  Stream<DocumentSnapshot> get personalUserData {
    return userProfilesCollection.doc(uid).snapshots();
  }
}
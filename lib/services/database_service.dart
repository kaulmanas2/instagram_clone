import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/models/posts.dart';
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
      Reference ref = FirebaseStorage.instance.ref(uid).child("${uid}_profile_pic");
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
          return await userPostsCollection.add({
            "caption": caption,
            "location": location,
            "post_url": downURL,
            "owner_id" : uid,
            "timestamp": DateTime.now()
          }).then((DocumentReference docRef) {
            String docID = docRef.id;
            userPostsCollection.doc(uid).collection("posts").doc(docID).update({
              "post_id" : docID
            });
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

  Stream<List<Posts>> get userPostsNew {
    return userPostsCollection.where("owner_id", isEqualTo: uid).snapshots().map(_postListFromSnapshotNew);
  }

  List<Posts> _postListFromSnapshotNew(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return Posts(
          caption: doc.data()["caption"].toString() ?? "",
          location: doc.data()["location"].toString() ?? "",
          downURL: doc.data()["post_url"].toString(),
          ownerID: doc.data()["owner_id"].toString(),
          timestamp: doc.data()["timestamp"].toDate(),
      );
    }).toList();
  }
}
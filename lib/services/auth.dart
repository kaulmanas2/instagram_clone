import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/services/database_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // stream to check if user is already logged in
  Stream<User> get user {
    return _firebaseAuth.authStateChanges();
  }

  Future signUpWithEmailAndPassword(String email, String password, String username) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      await DatabaseService(uid: userCredential.user.uid).setUserProfileData(username);
      return userCredential.user;
    }
    catch (e) {
      print("Error in registration ${e.toString()}");
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      return userCredential.user;
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  String get uid {
    return _firebaseAuth.currentUser.uid;
  }

  Future setDisplayName(String displayName) async {
    try {
      return await _firebaseAuth.currentUser.updateProfile(
        displayName: displayName,
      );
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  String get displayName {
    return _firebaseAuth.currentUser.displayName;
  }

  String get userEmail {
    return _firebaseAuth.currentUser.email;
  }
}
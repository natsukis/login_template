import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_template/model/user.dart';
import 'package:login_template/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFireBaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change Stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFireBaseUser(user));
        .map(_userFromFireBaseUser);
  }

  // sign in anon
  // Future signInAnon() async {
  //   try {
  //     AuthResult result = await _auth.signInAnonymously();
  //     FirebaseUser user = result.user;
  //     return _userFromFireBaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // sign in email
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document for the user with he uid
      await DatabaseService(uid: user.uid)
          .updateUserData(email, '', '', '','');

      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // log out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

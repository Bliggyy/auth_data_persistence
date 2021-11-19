import 'package:basecode/widgets/ErrorAlert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount user;

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser?.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> createUser(
      String email, String password, BuildContext context) async {
    UserCredential _userCredential;
    try {
      // I had to use createUserWithEmailAndPassword because using signInWithEmailAndPassword returned null
      _userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showDialog(
            context: context,
            builder: (context) => ErrorAlert(content: 'Email already exists.'));
      } else if (e.code == 'weak-password') {
        showDialog(
            context: context,
            builder: (context) => ErrorAlert(
                content: 'Your password is too weak please try again.'));
      }
    } catch (e) {
      print(e);
    }
    return _userCredential;
  }

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
            context: context,
            builder: (context) => ErrorAlert(content: 'User does not exist.'));
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showDialog(
            context: context,
            builder: (context) =>
                ErrorAlert(content: 'Wrong password provided for that user.'));
        print('Wrong password provided for that user.');
      }
    } catch (e) {}
    return userCredential;
  }

  Future logout() async {
    try {
      await googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      return null;
    }
  }
}

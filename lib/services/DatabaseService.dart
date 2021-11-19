import 'package:basecode/services/AuthService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  static CollectionReference _users =
      FirebaseFirestore.instance.collection("users");

  static AuthService _authService = AuthService();

  Future<UserCredential> registerUser(user, context) async {
    try {
      // Wanted to try out the error catching of FirebaseAuthException
      // var checkEmail = await _users.where("email", isEqualTo: user.email).get();

      // if (checkEmail.docs.length > 0) {
      //   return null;
      // }

      UserCredential userCredential =
          await _authService.createUser(user.email, user.password, context);

      await _users.doc(userCredential.user.uid).set({
        "firstname": user.firstName,
        "lastname": user.lastName,
        "email": user.email
      });

      return userCredential;
    } catch (e) {
      return null;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_signup/user_model.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUp(
      {required String email,
      required String password,
      required String name,
      required String surname}) async {
    String result = 'Some error occured.';

    if (email.isNotEmpty &&
        password.isNotEmpty &&
        name.isNotEmpty &&
        surname.isNotEmpty) {
      try {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          UserModel userModel = UserModel(
              email: email,
              name: name,
              surname: surname,
              uid: userCredential.user!.uid);

          await _firestore
              .collection('Utenti')
              .doc(userCredential.user!.uid)
              .set(userModel.toJson());
          result = 'Ok';
        }
      } catch (e) {
        // Remove firebase auth exception's codes from the string
        result = e.toString().replaceAll(RegExp(r'\[.*?\]'), '');
      }
    } else {
      result = 'All fields are required.';
    }
    return result;
  }

  Future<String> signIn(
      {required String email, required String password}) async {
    String result = 'Some error occured.';

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (userCredential.user != null) {
          result = 'Ok';
        }
      } catch (e) {
        // Remove firebase auth exception's codes from the string
        result = e.toString().replaceAll(RegExp(r'\[.*?\]'), '');
        if (result.contains('An internal error has occurred.')) {
          result = 'The email or password is incorrect.';
        }
      }
    } else {
      result = 'All fields are required.';
    }
    return result;
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<UserModel?> getCurrentUserData() async {
    return UserModel.fromSnap(await _firestore
        .collection('Utenti')
        .doc(_auth.currentUser?.uid)
        .get());
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}

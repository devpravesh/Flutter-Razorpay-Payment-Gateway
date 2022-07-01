import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signin(email, password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {});
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong Password");
      }
      if (e.code == 'invalid-email') {
        Fluttertoast.showToast(msg: "Invalid Email");
      }
      if (e.code == "user-not-found") {
        Fluttertoast.showToast(msg: "No such Email");
      }
    }
  }
}

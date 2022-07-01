import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forpionifty/payment.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

class SignInController extends GetxController {
  RxBool isLoading = true.obs;
  var response;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> signin(email, password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.offAll(() => RazorpayPage());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong Password");
      }
      if (e.code == 'invalid-email') {
        Fluttertoast.showToast(msg: "Invalid Email");
      }
      if (e.code == "user-not-found") {
        Fluttertoast.showToast(msg: "User doesn't exist");
      }
    }
  }

  // Checking for payment of fees
  Future<bool> getPaymentStatus() async {
    isLoading(true);
    var getId = FirebaseAuth.instance.currentUser!.uid;
    response = await _db.collection('Students').doc(getId.toString()).get();
    // print(response.data());
    isLoading(false);
    return response.data()!['feepaid'];
  }

  @override
  void onInit() {
    getPaymentStatus();
    // TODO: implement onInit
    super.onInit();
  }
}

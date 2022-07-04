import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forpionifty/payment.dart';
import 'package:forpionifty/view/student_id.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  RxBool isLoading = true.obs;
  var qrImage;
  var response;

  Future<void> signin(email, password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // .then((value) async {
      // change the logic for routing after
      // This function also reads the data from the Firebase
      var checkPaymnet = await getPaymentStatus();
      if (checkPaymnet) {
        Get.offAll(() => StudentID());
      } else {
        Get.offAll(() => RazorpayPage());
      }
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
    response = await _db.collection('Students').doc(getId).get();
    // print(response.data());
    // log(response.data()!["Name"].toString());
    isLoading(false);
    return response.data()!['feepaid'];
  }

  updatePaymentStatus() async {
    isLoading(true);
    String getId = _auth.currentUser!.uid;
    await _db.collection('Students').doc(getId).update({'feepaid': true});
    isLoading(false);
    Get.offAll(() => StudentID());
  }

  updateNameandPhone({required String name, required phone}) async {
    isLoading(true);
    String getId = _auth.currentUser!.uid;
    await _db
        .collection('Students')
        .doc(getId)
        .update({'Name': name, 'phone': phone});
    Get.back();
    isLoading(false);
  }

  @override
  void onInit() {
    getPaymentStatus();
    // TODO: implement onInit
    super.onInit();
  }
}

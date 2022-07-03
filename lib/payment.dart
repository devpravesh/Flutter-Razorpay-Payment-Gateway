import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forpionifty/controller/signIn.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPage extends StatefulWidget {
  @override
  _RazorpayPageState createState() => _RazorpayPageState();
}

class _RazorpayPageState extends State<RazorpayPage> {
  SignInController _control = Get.find<SignInController>();
  static const platform = MethodChannel("razorpay_flutter");

  late Razorpay _razorpay;
  var amount = 100;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Payment Page'),
        ),
        bottomNavigationBar: BottomAppBar(
            child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Pending Fee =" + _control.response.data()['fee'],
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(onPressed: openCheckout, child: const Text('Open'))
          ],
        )),
        body: const Center(child: Text("Pay the fee to continue"))
        // Obx(() => _control.isLoading.value
        //     ? Center(child: CircularProgressIndicator())
        //     :

        );
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    // Test with this card : 4111 1111 1111 1111

    var options = {
      'key': 'rzp_test_HgHQSj3tYGQCWc',
      'amount': 10000,
      'name': 'Pionifty.',
      'description': 'Tejsingh',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }
}

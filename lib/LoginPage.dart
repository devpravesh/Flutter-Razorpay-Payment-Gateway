import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:forpionifty/controller/signIn.dart';
import 'package:forpionifty/utils/utilsForproj.dart';
import 'package:get/get.dart';

class Loginpage extends StatelessWidget {
  Loginpage({Key? key}) : super(key: key);

  SignInController _control = Get.put(SignInController());
  final username = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign In")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            TextFormField(
              controller: username,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Username'),
                  floatingLabelBehavior: FloatingLabelBehavior.auto),
            ),
            UtilsForproj().constSpace(horizontal: false),
            TextFormField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('password'),
                  floatingLabelBehavior: FloatingLabelBehavior.auto),
            ),
            ElevatedButton(
                onPressed: () async {
                  _control.signin(username.text, password.text);
                },
                // _control.signin(username.toString(), password.toString()),
                child: const Text("Login"))
          ]),
        ),
      ),
    );
  }
}

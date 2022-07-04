// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:forpionifty/controller/signIn.dart';
import 'package:forpionifty/utils/utilsForproj.dart';
import 'package:forpionifty/view/edit.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class StudentID extends StatelessWidget {
  StudentID({Key? key}) : super(key: key);
  SignInController _controller = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    UtilsForproj utils = UtilsForproj();

    return Scaffold(
        appBar: AppBar(
          title: Text("Profile Page"),
        ),
        body: Obx(
          () => _controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    utils.constSpace(horizontal: false),
                    Center(
                      child: Container(
                        width: Get.width - 10,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.deepPurple[300],
                            borderRadius: BorderRadius.circular(16)),
                        child: Wrap(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                QrImage(
                                    data:
                                        _controller.response.data()!.toString(),
                                    size: 150,
                                    dataModuleStyle: const QrDataModuleStyle(
                                        dataModuleShape:
                                            QrDataModuleShape.square,
                                        color: Colors.white),
                                    eyeStyle: const QrEyeStyle(
                                        eyeShape: QrEyeShape.square,
                                        color: Colors.white)),
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.,
                                  children: [
                                    // _controller.generateQR(),
                                    // const Text(
                                    //   "OR CODE",
                                    //   style: TextStyle(color: Colors.white),
                                    // ),
                                    Text(
                                      _controller.response.data()!['Name'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 24),
                                    ),
                                    utils.constSpace(horizontal: false),
                                    Text(
                                        _controller.response.data()!['academy'],
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.white,
                                            fontSize: 18)),
                                    utils.constSpace(horizontal: false),
                                    Text(_controller.response.data()!['phone'],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18))
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    utils.constSpace(horizontal: false),
                    ListTile(
                      title: Text("Change Academy"),
                      onTap: () => log("Academy change request"),
                    ),
                    utils.constSpace(horizontal: false),
                    ListTile(
                      title: Text("Edit Profile"),
                      onTap: () => Get.to(() => edit(
                            name: _controller.response.data()['Name'],
                            phone: _controller.response.data()['phone'],
                          )),
                    ),
                  ],
                ),
        ));
  }
}

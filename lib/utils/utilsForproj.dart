// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UtilsForproj {
  Widget textForInput(isPassword, {required name, required controller}) {
    String? name;
    TextEditingController? controller;
    bool? isPassword;
    return TextField(
      controller: controller!,
      decoration: InputDecoration(
          border: const OutlineInputBorder(), label: Text(name!)),
    );
  }

  Widget constSpace({required horizontal}) {
    if (horizontal) {
      return const SizedBox(
        height: 10,
      );
    }

    return const SizedBox(
      width: 10,
    );
  }
}

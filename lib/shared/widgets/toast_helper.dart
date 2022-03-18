import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(
  String message,
  ToastType type,
) {
  Fluttertoast.showToast(
      msg: "This is Center Short Toast",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: {
        ToastType.error: Colors.red,
        ToastType.info: Colors.blue,
        ToastType.success: Colors.green
      }[type],
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastType { error, info, success }

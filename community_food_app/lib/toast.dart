import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


void showToast({required String message}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: const Color.fromARGB(255, 3, 71, 50),
    textColor: Colors.white,
    fontSize: 16.0
  );
}
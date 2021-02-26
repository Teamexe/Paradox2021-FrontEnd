import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void createToast(String message){

  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 15.0);
}
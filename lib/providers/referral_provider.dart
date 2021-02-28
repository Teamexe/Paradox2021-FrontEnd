import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:paradox/utilities/Toast.dart';
import 'package:paradox/utilities/constant.dart';

class ReferralProvider extends ChangeNotifier {
  Future<bool> availReferral(String code, String userId) async {
    String url = '${baseUrl}refferral/';
    Response response =
        await post(url, body: {"ref_code": code, "user": userId});
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      createToast(body['message']);
      notifyListeners();
      return true;
    } else if (response.statusCode == 400) {
      try {
        createToast(body['ref_code'][0]);
      } catch (e) {
        createToast(body['message']);
      }
      return false;
    } else {
      createToast('There was some error please try again later');
      return false;
    }
  }
}

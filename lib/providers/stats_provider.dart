import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paradox/utilities/constant.dart';
import 'package:http/http.dart';

class StatsProvider extends ChangeNotifier {
  int attempts;
  int totalUsers;
  int totalQuestions;
  int totalQuestionsAnswered;

  Future<void> fetchAndSetStats() async {
    String url = '${baseUrl}stats/';
    try {
      Response response = await get(url);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        this.attempts = body['attempts'];
        this.totalQuestions = body["total questions"];
        this.totalUsers = body["total users"];
        this.totalQuestionsAnswered = body["total questions answered"];
        notifyListeners();
      }
    } catch (e) {
      throw Exception();
    }
    return null;
  }
}

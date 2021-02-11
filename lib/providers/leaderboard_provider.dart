import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:paradox/models/LeaderBoardUser.dart';
import 'package:paradox/utilities/constant.dart';

class LeaderBoardProvider extends ChangeNotifier {
  List<LeaderBoardUser> _userList;

  List<LeaderBoardUser> get userList => [..._userList];

  void fetchAndSetLeaderBoard() async {
    String route = "leaderboard/";
    String url = "$baseUrl$route";
    Response response = await get(url);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
    } else {
      throw Exception();
    }
    notifyListeners();
  }
}

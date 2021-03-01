import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:paradox/models/leaderBoardUser.dart';
import 'package:paradox/utilities/constant.dart';

class LeaderBoardProvider extends ChangeNotifier {
  /// _userList Store List of [LeaderBoardUser] for leaderboard
  List<LeaderBoardUser> _userList = [];

  /// Getter for [_userList]
  List<LeaderBoardUser> get userList => [..._userList];

  /// This function fetchers List of [LeaderBoardUser] from backend and assign them to [_userList]
  Future<void> fetchAndSetLeaderBoard() async {
    String route = "leaderboard/";

    /// URl to place request
    String url = "$baseUrl$route";

    /// Placing Request on Backend
    Response response = await get(url);
    if (response.statusCode == 200) {
      /// Clearing [_userList]
      _userList.clear();

      /// Decoding Response Received
      var data = jsonDecode(response.body);

      /// Looping over List of users and adding them to _userList
      for (int i = 0; i < data.length; i++) {
        _userList.add(
          LeaderBoardUser(
            user: data[i]['user'],
            name: data[i]['name'],
            image: data[i]['image'],
            level: data[i]['level'],
            score: data[i]['score'],
            coins: data[i]['coins'],
          ),
        );
      }

      /// Notifying Listeners
      notifyListeners();
    } else {
      throw Exception();
    }
  }

  List<LeaderBoardUser> get topPlayerList {
    // TODO: return top 10 players
    return _userList.sublist(0);
  }

  int getRank(String id) {
     for(int i = 0;i<userList.length;i++){
       if(userList[i].user == id){
         return i+1;
       }
     }
  }
}

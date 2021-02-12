import 'package:flutter/material.dart';

class LeaderBoardUser {
  String user;
  String name;
  String image;
  int level;
  int score;
  int coins;

  LeaderBoardUser(
      {@required this.user,
      @required this.name,
      @required this.image,
      @required this.level,
      @required this.score,
      @required this.coins});
}

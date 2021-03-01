import 'package:flutter/material.dart';

class User {
  String uid;
  String email;
  String profileImage;
  String referralCode;
  String name;
  int score;
  int level;
  int coins;
  int attempts;
  int superCoins;
  bool referralAvailed;
  int hintLevel;

  User({@required this.uid, @required this.email, @required this.name});
}

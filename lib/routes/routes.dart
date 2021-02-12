import 'package:flutter/widgets.dart';
import 'package:paradox/screens/leaderboard_screen.dart';
import '../authentication/sign_in.dart';
import '../screens/home_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  SignIn.routeName: (context) => SignIn(),
  Home.routeName: (context) => Home(),
  LeaderBoard.route: (context) => LeaderBoard()
};

import 'package:flutter/widgets.dart';
import 'package:paradox/screens/InfoScreen.dart';
import 'package:paradox/screens/Referral.dart';
import 'package:paradox/screens/stageCompleted_screen.dart';
import 'package:paradox/screens/stats_screen.dart';
import '../utilities/member_screen.dart';
import 'package:paradox/utilities/member_screen.dart';
import '../screens/question_screen.dart';
import '../screens/leaderboard_screen.dart';
import 'package:paradox/screens/leaderboard_screen.dart';
import 'package:paradox/screens/rules_screen.dart';
import 'package:paradox/screens/user_profile_screen.dart';
import '../authentication/sign_in.dart';
import '../screens/home_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  SignIn.routeName: (context) => SignIn(),
  Home.routeName: (context) => Home(),
  LeaderBoard.route: (context) => LeaderBoard(),
  QuestionScreen.routeName: (context) => QuestionScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  RulesScreen.routeName: (context) => RulesScreen(),
  ReferralScreen.routeName: (context) => ReferralScreen(),
  MemberScreen.routeName: (context) => MemberScreen(),
  StatsScreen.routeName: (context) => StatsScreen(),
  StageCompleted.routeName: (context) => StageCompleted(),
  InfoScreen.routeName: (context) => InfoScreen()
};

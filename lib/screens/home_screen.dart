import 'package:flutter/material.dart';
import 'package:paradox/screens/leaderboard_screen.dart';
import 'package:paradox/widgets/appbar.dart';
import 'package:paradox/widgets/drawer.dart';

class Home extends StatelessWidget {
  static String routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: AppDrawer(),
    );
  }
}


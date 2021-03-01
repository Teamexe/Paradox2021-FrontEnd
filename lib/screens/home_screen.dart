import 'package:flutter/material.dart';
import 'package:paradox/providers/user_provider.dart';
import 'package:paradox/screens/question_screen.dart';
import 'package:paradox/screens/user_profile_screen.dart';
import 'package:paradox/utilities/curve_painter.dart';
import 'package:paradox/widgets/drawer.dart';

import 'leaderboard_screen.dart';

class Home extends StatelessWidget {
  static String routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Paradox'),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: FlatButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image(
                  image: NetworkImage(UserProvider().getUserProfileImage()),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, ProfileScreen.routeName);
              },
            ),
          ),
        ],
      ),

      body: Container(
        color: Colors.white,
        child: CustomPaint(
          painter: CurvePainter(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  child: TextButton(
                    child: Text("LeaderBoard"),
                    onPressed: () {
                      Navigator.of(context).pushNamed(LeaderBoard.route);
                    },
                  ),
                ),
                Container(
                  child: TextButton(
                    child: Text("Question"),
                    onPressed: () {
                      Navigator.of(context).pushNamed(QuestionScreen.routeName);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}

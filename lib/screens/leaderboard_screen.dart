import 'package:flutter/material.dart';
import 'package:paradox/models/leaderBoardUser.dart';
import 'package:paradox/providers/leaderboard_provider.dart';
import 'package:paradox/widgets/usercard.dart';
import 'package:provider/provider.dart';

class LeaderBoard extends StatelessWidget {
  static String route = "/leaderBoard";

  @override
  Widget build(BuildContext context) {
    List<LeaderBoardUser> users =
        Provider.of<LeaderBoardProvider>(context, listen: true).userList;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff002a1e),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
         Navigator.pop(context);
        },),

        title: Text(
          "Leaderboard",
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: Color(0xff002a1e),
      body: ListView.builder(
          itemBuilder: (ctx, index) {
            return UserCardWidget(users[index], index + 1);
          },
          itemCount: users.length),
    );
  }
}

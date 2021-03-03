import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:paradox/models/leaderBoardUser.dart';
import 'package:paradox/providers/leaderboard_provider.dart';
import 'package:paradox/providers/theme_provider.dart';
import 'package:paradox/providers/user_provider.dart';
import 'package:paradox/utilities/myBehaviour.dart';
import 'package:paradox/widgets/usercard.dart';
import 'package:provider/provider.dart';

class LeaderBoard extends StatefulWidget {
  static String route = "/leaderBoard";

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  bool load = true;

  @override
  void initState() {
    super.initState();
    update();
  }

  void update() async {
    setState(() {
      load = true;
    });
    if (Provider.of<LeaderBoardProvider>(context, listen: false)
            .userList
            .length ==
        0) {
      await Provider.of<LeaderBoardProvider>(context, listen: false)
          .fetchAndSetLeaderBoard();
    }
    setState(() {
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<LeaderBoardUser> users =
        Provider.of<LeaderBoardProvider>(context, listen: true).userList;
    final currentUser = Provider.of<UserProvider>(context, listen: true).user;
    final userImage = Provider.of<UserProvider>(context, listen: true).getUserProfileImage();
    final rank = users.indexWhere((userUid) => userUid.user == currentUser.uid);
    final brightness = Provider.of<ThemeProvider>(context).brightnessOption;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: brightness == BrightnessOption.light ? Colors.white : Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          'Leaderboard'.toUpperCase(),
          style: TextStyle(
              color: brightness == BrightnessOption.light ? Color(0xff0083B0) : Colors.white,
              letterSpacing: 3,
              fontWeight: brightness == BrightnessOption.dark ? FontWeight.w300 : FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        leading: Container(
          margin: const EdgeInsets.all(5),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: brightness == BrightnessOption.light ? Color(0xff0083B0) : Colors.white,
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Container(
        decoration: brightness == BrightnessOption.light ?
        BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffADA996),
            Color(0xfff2f2f2),
            Color(0xffdbdbdb),
            Color(0xffeaeaea),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        )
        : BoxDecoration(),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    gradient: LinearGradient(colors: [
                      brightness == BrightnessOption.light ? Color(0xff0083B0) : Colors.grey,
                      brightness == BrightnessOption.light ? Color(0xff00B4DB) :Colors.white,
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    boxShadow: [
                      brightness == BrightnessOption.light ?
                      BoxShadow   (
                        color: Color(0xff0083B0),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      )
                      : BoxShadow(),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Rank: ${rank + 1}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w400),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            child: CircleAvatar(
                              radius: 39,
                              backgroundColor: brightness == BrightnessOption.light ? Colors.white38 : Colors.grey[500].withOpacity(0.7),
                              child: CircleAvatar(
                                radius: 36,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(userImage),
                              ),
                            ),
                          ),
                          Text(
                            'Score: ${currentUser.score ?? 0}',
                            style: TextStyle(
                                color: brightness == BrightnessOption.light ? Colors.white : Colors.grey,
                                fontSize: 18,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                // padding: EdgeInsets.only(top: 20, right: 20),
                // height: size.height * 0.7,
                child: load
                    ? SpinKitDualRing(color: Colors.white)
                    : ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: ListView.builder(
                            itemBuilder: (ctx, index) {
                              return UserCardWidget(users[index], index + 1);
                            },
                            itemCount: users.length),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

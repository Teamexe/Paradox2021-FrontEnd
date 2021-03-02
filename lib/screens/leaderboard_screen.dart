import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paradox/models/leaderBoardUser.dart';
import 'package:paradox/providers/leaderboard_provider.dart';
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

    final rank = users.indexWhere((userUid) => userUid.user == currentUser.uid);
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffADA996),
            Color(0xfff2f2f2),
            Color(0xffdbdbdb),
            Color(0xffeaeaea),
            // Color(0xff1A2980),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: size.height * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    gradient: LinearGradient(colors: [
                      Color(0xff0083B0),
                      Color(0xff00B4DB),
                      // Color(0xff1A2980),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff0083B0),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Center(
                      child: Text(
                        'Leaderboard',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Rank: ${rank + 1}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                  FirebaseAuth.instance.currentUser.photoURL),
                            ),
                          ),
                          Text(
                            'Score: ${currentUser.score ?? 0}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, right: 20),
                height: size.height * 0.7,
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

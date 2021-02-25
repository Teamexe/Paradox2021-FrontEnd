import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paradox/providers/user_provider.dart';
import 'package:paradox/screens/leaderboard_screen.dart';
import 'package:paradox/utilities/Toast.dart';
import 'package:paradox/utilities/logo_painter.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
  final name = UserProvider().getUserName();
  final email = UserProvider().getUserEmail();
  final image = UserProvider().getUserProfileImage();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  accountEmail: Text(email, style: TextStyle(fontWeight: FontWeight.w500)),
                  currentAccountPicture: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image(
                      image: NetworkImage(image),
                    ),
                  ),
                  decoration: BoxDecoration(color: Theme.of(context).accentColor),
                  onDetailsPressed: () {

                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.local_activity, color: Colors.white),
                    backgroundColor: Colors.blue,
                  ),
                  title: Text('Ranking'),
                  dense: true,
                  onTap: () {
                    Navigator.pushNamed(context, LeaderBoard.route);
                  },
                ),
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Transform.rotate(
                      angle: pi / 3,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: CustomPaint(
                          painter: MyLogoPainter(),
                          child: Container(),
                        ),
                      ),
                    ),
                  ),
                  dense: true,
                  title: Text('Paradox'),
                ),
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.graphic_eq, color: Colors.white),
                  ),
                  title: Text('Stats'),
                  dense: true,
                ),
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.people, color: Colors.white),
                  ),
                  title: Text('Referral'),
                  dense: true,
                ),
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.group_sharp, color: Colors.white),
                  ),
                  title: Text('Members'),
                  dense: true,
                ),
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.info_rounded, color: Colors.white),
                  ),
                  title: Text('Information'),
                  dense: true,
                ),
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.rule, color: Colors.white),
                  ),
                  title: Text('View Rules'),
                  dense: true,
                ),
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.settings_applications, color: Colors.white),
                  ),
                  title: Text('Settings'),
                  dense: true,
                ),
                Divider(),
                ListTile(
                  isThreeLine: false,
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.logout, color: Colors.white),
                  ),
                  title: Text('Logout'),
                  dense: true,
                  onTap: () {
                    UserProvider().logout();
                    createToast('Signed out successfully');
                  },
                ),
                Divider(),

              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(text: 'Made with '),
                      TextSpan(
                          text: String.fromCharCode(0x2665),
                          style: TextStyle(
                              fontFamily: 'Material Icons',
                              fontSize: 17,
                              color: Colors.lightBlue[900].withAlpha(1000),
                              fontWeight: FontWeight.bold)
                      ),
                      TextSpan(text: ' by '),
                      TextSpan(
                          text: 'Team .E',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.lightBlue[900].withAlpha(1000),
                              fontWeight: FontWeight.bold)
                      ),
                      TextSpan(
                          text: 'X',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.bold)
                      ),
                      TextSpan(
                          text: 'E',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.lightBlue[900].withAlpha(1000),
                              fontWeight: FontWeight.bold)),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paradox/providers/user_provider.dart';
import 'package:paradox/screens/Referral.dart';
import 'package:paradox/screens/leaderboard_screen.dart';
import 'package:paradox/screens/rules_screen.dart';
import 'package:paradox/screens/user_profile_screen.dart';
import 'package:paradox/utilities/Toast.dart';
import 'package:paradox/utilities/custom_dialog.dart';
import 'package:paradox/utilities/logo_painter.dart';
import 'package:paradox/utilities/member_screen.dart';
import 'package:paradox/utilities/privacy_policy.dart';
import 'package:url_launcher/url_launcher.dart';

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
    TextStyle textStyle = TextStyle(
      color: Colors.grey.shade500,
      fontSize: 15,
      fontWeight: FontWeight.w600,
    );

    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                GestureDetector(
                  child: UserAccountsDrawerHeader(
                    accountName: Text(name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    accountEmail: Text(email,
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    currentAccountPicture: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image(
                        image: NetworkImage(image),
                      ),
                    ),
                    decoration:
                        BoxDecoration(color: Colors.blue),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, ProfileScreen.routeName);
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.leaderboard, color: Colors.white),
                    backgroundColor: Colors.blue,
                  ),
                  title: Text('LeaderBoard', style: textStyle),
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
                          painter: MyLogoPainter(Colors.white),
                          child: Container(),
                        ),
                      ),
                    ),
                  ),
                  dense: true,
                  title: Text('Paradox', style: textStyle),
                ),
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.graphic_eq, color: Colors.white),
                  ),
                  title: Text('Stats', style: textStyle),
                  dense: true,
                ),
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.people, color: Colors.white),
                  ),
                  title: Text('Referral', style: textStyle),
                  dense: true,
                  onTap: () {
                    Navigator.of(context).pushNamed(ReferralScreen.routeName);
                  },
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(MemberScreen.routeName);
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.group_sharp, color: Colors.white),
                  ),
                  title: Text('Members', style: textStyle),
                  dense: true,
                ),
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child:
                        Icon(Icons.info_outline_rounded, color: Colors.white),
                  ),
                  title: Text('Information', style: textStyle),
                  dense: true,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogBox(
                              'Information',
                              'View our projects on ',
                              'https://github.com/teamexe',
                              '\n or visit our website ',
                              'https://teamexe.in',
                              Colors.blue);
                        });
                  },
                ),
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.list_rounded, color: Colors.white),
                  ),
                  title: Text('View Rules', style: textStyle),
                  dense: true,
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (ctx, animation, _) {
                          return RulesScreen();
                        }));
                  },
                ),
                Divider(),
                ListTile(
                  isThreeLine: false,
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.lock, color: Colors.white),
                  ),
                  title: Text('Privacy Policy', style: textStyle),
                  dense: true,
                  onTap: () async {
                    Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (ctx, animation, _) {
                          return PrivacyPolicyWidget();
                        }));
                  },
                ),
                Divider(),
                ListTile(
                  isThreeLine: false,
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.logout, color: Colors.white),
                  ),
                  title: Text('Logout', style: textStyle),
                  dense: true,
                  onTap: () {
                    UserProvider().logout();
                    createToast('Signed out successfully');
                  },
                ),
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
                        color: Colors.grey[400],
                        fontWeight: FontWeight.normal),
                    children: [
                      TextSpan(text: 'Made with '),
                      TextSpan(
                          text: String.fromCharCode(0x2665),
                          style: TextStyle(fontFamily: 'Material Icons')),
                      TextSpan(text: ' by '),
                      TextSpan(

                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            if (await canLaunch('https://teamexe.in')) {
                              launch('https://teamexe.in');
                            } else {
                              throw 'Could not launch https://teamexe.in';
                            }
                          },
                          text: 'Team .E',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.lightBlue[900].withAlpha(1000),
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              if (await canLaunch('https://teamexe.in')) {
                                launch('https://teamexe.in');
                              } else {
                                throw 'Could not launch https://teamexe.in';
                              }
                          },
                          text: 'X',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              if (await canLaunch('https://teamexe.in')) {
                                launch('https://teamexe.in');
                              } else {
                                throw 'Could not launch https://teamexe.in';
                              }
                          },
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

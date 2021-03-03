import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paradox/providers/user_provider.dart';

import 'package:paradox/screens/Referral.dart';

import 'package:paradox/widgets/customCard.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/user_profile_screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true).user;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // height: size.height * 0.1,
                  // width: size.height * 0.1,
                  margin: EdgeInsets.only(top: size.height * 0.03),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              UserProvider().getUserProfileImage()),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              child: Text(
                                UserProvider().getUserName(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            Container(
                              child: Text(
                                UserProvider().getUserEmail(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        CustomCard(
                          heading1: ' Level : ${user.level ?? 1} ',
                          heading2: ' Coins : ${user.coins ?? 0}',
                          imagePath: "assets/images/badge.png",
                        ),
                        CustomCard(
                          heading1: ' Score : ${user.score ?? 0}',
                          heading2: ' Attempts : ${user.attempts??0}',
                          imagePath: "assets/images/trophy.png",
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                            width: double.infinity,
                            child: MaterialButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(ReferralScreen.routeName);
                                },
                                height: 48,
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Referral',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(17.0),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.normal),
                                children: [
                                  TextSpan(text: 'Made with '),
                                  TextSpan(
                                      text: String.fromCharCode(0x2665),
                                      style: TextStyle(
                                          fontFamily: 'Material Icons')),
                                  TextSpan(text: ' by '),
                                  TextSpan(
                                    text: 'Team .E',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Colors.lightBlue[900].withAlpha(1000),
                                    ),
                                  ),
                                  TextSpan(
                                      text: 'X',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.lightBlue,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: 'E',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.lightBlue[900]
                                              .withAlpha(1000),
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// OLD CODE
/*Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image(
                    image: NetworkImage(UserProvider().getUserProfileImage()),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      child: Text(UserProvider().getUserName()),
                    ),
                    Container(
                      child: Text(UserProvider().getUserEmail()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),*/

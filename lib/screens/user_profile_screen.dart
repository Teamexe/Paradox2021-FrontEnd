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
      appBar: AppBar(
        title: Text('PROFILE',
            style: TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.w300,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: Container(
          padding: const EdgeInsets.all(10),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: size.height * 0.02),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: CircleAvatar(
                      radius: 39,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                            UserProvider().getUserProfileImage()),
                      ),
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
                              fontSize: 22,
                              letterSpacing: 3,
                              fontWeight: FontWeight.w300,
                            ),
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          child: Text(
                            UserProvider().getUserEmail(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 22,
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
            SizedBox(height: 30),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[400], // white
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)
                    ),
                  ),
                  width: double.infinity,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomCard(
                            heading1: ' Level : ${user.level ?? 1} ',
                            heading2: ' Coins : ${user.coins ?? 0}',
                            imagePath: "assets/images/badge.png",
                          ),
                          CustomCard(
                            heading1: ' Score : ${user.score ?? 0}',
                            heading2: ' Attempts : ${user.attempts}',
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
                          SizedBox(height: 60),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}

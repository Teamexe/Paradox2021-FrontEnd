import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:paradox/providers/theme_provider.dart';
import 'package:paradox/providers/user_provider.dart';
import 'package:paradox/screens/Referral.dart';
import 'package:paradox/widgets/customCard.dart';
import 'package:paradox/widgets/custom_card_dark_theme.dart';
import 'package:paradox/widgets/no_data_connection.dart';
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
    final brightness =
        Provider.of<ThemeProvider>(context, listen: true).brightnessOption;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PROFILE',
          style: TextStyle(
            letterSpacing: 2,
            fontWeight: brightness == BrightnessOption.dark
                ? FontWeight.w300
                : FontWeight.normal,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: AbsorbPointer(
          absorbing: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected ? true : false,
          child: Opacity(
            opacity: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected ? 0.2 : 1,
            child: Container(
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
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            AbsorbPointer(
              absorbing: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected ? true : false,
              child: Opacity(
                opacity: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected ? 0.2 : 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width,
                      color: brightness == BrightnessOption.dark
                          ? Colors.transparent
                          : Colors.blue,
                      padding: EdgeInsets.only(top: size.height * 0.02),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            child: CircleAvatar(
                              radius: 39,
                              backgroundColor: brightness == BrightnessOption.dark
                                  ? Colors.grey
                                  : Colors.white,
                              child: CircleAvatar(
                                radius: 36,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    NetworkImage(UserProvider().getUserProfileImage()),
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
                                      color: brightness == BrightnessOption.dark
                                          ? Colors.grey
                                          : Colors.white60,
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
                    SizedBox(
                      height: 30,
                      child: Container(
                        width: size.width,
                        color: brightness == BrightnessOption.dark
                            ? Colors.transparent
                            : Colors.blue,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: brightness == BrightnessOption.dark
                              ? Colors.transparent
                              : Colors.blue,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: brightness == BrightnessOption.dark
                                ? Colors.grey[400]
                                : Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                          ),
                          width: double.infinity,
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  brightness == BrightnessOption.dark
                                      ? DarkCustomCard(
                                          heading1: 'Level: ${user.level ?? 1} ',
                                          heading2: 'Coins: ${user.coins ?? 0}',
                                          imagePath: "assets/images/badge.png",
                                        )
                                      : CustomCard(
                                          heading1: 'Level: ${user.level ?? 1} ',
                                          heading2: 'Coins: ${user.coins ?? 0}',
                                          imagePath: "assets/images/badge.png",
                                        ),
                                  brightness == BrightnessOption.dark
                                      ? DarkCustomCard(
                                          heading1: 'Score: ${user.score ?? 0}',
                                          heading2: 'Attempts: ${user.attempts}',
                                          imagePath: "assets/images/trophy.png",
                                        )
                                      : CustomCard(
                                          heading1: 'Score: ${user.score ?? 0}',
                                          heading2: 'Attempts: ${user.attempts}',
                                          imagePath: "assets/images/trophy.png",
                                        ),
                                  SizedBox(height: 10),
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
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color:
                                                    brightness == BrightnessOption.light
                                                        ? Colors.grey[100]
                                                        : Colors.white,
                                                width:
                                                    brightness == BrightnessOption.light
                                                        ? 2
                                                        : 3,
                                                style: BorderStyle.solid),
                                            borderRadius: BorderRadius.circular(10.0),
                                          )),
                                    ),
                                  ),
                                  SizedBox(height: 40),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: brightness == BrightnessOption.light
                          ? Colors.blue
                          : Colors.transparent,
                      alignment: Alignment.center,
                      height: 50,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 2,
                                color: brightness == BrightnessOption.light
                                    ? Colors.white
                                    : Colors.grey[400],
                                fontWeight: FontWeight.w400),
                            children: [
                              TextSpan(text: 'Made with '),
                              TextSpan(
                                  text: String.fromCharCode(0x2665),
                                  style: TextStyle(fontFamily: 'Material Icons')),
                              TextSpan(text: ' by '),
                              TextSpan(
                                text: 'Team .E',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: brightness == BrightnessOption.dark
                                      ? Colors.lightBlue
                                      : Colors.lightBlue[900].withAlpha(1000),
                                ),
                              ),
                              TextSpan(
                                  text: 'X',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: brightness == BrightnessOption.dark
                                          ? Colors.blue[200]
                                          : Colors.lightBlue[100],
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: 'E',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: brightness == BrightnessOption.dark
                                          ? Colors.lightBlue
                                          : Colors.lightBlue[900].withAlpha(1000),
                                      fontWeight: FontWeight.bold)),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected,
              child: NoDataConnectionWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

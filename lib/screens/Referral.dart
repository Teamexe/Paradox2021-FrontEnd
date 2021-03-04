import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:paradox/models/user.dart';
import 'package:paradox/providers/referral_provider.dart';
import 'package:paradox/providers/theme_provider.dart';
import 'package:paradox/providers/user_provider.dart';
import 'package:paradox/utilities/Toast.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class ReferralScreen extends StatefulWidget {
  static String routeName = "/referral-Screen";

  @override
  _ReferralScreenState createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  bool loader = false;
  TextEditingController referralCodeController = new TextEditingController();

  @override
  void dispose() {
    referralCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context, listen: true).user;
    final availReferral =
        Provider.of<ReferralProvider>(context, listen: true).availReferral;
    final brightness =
        Provider.of<ThemeProvider>(context, listen: true).brightnessOption;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Referral".toUpperCase(),
          style: TextStyle(
            fontWeight: brightness == BrightnessOption.light
                ? FontWeight.w400
                : FontWeight.w300,
            letterSpacing: 2,
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
      body: Container(
        child: TweenAnimationBuilder(
          tween: Tween(begin: 0.0, end: 1.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (user.referralAvailed == false)
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Avail Referral",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: brightness == BrightnessOption.light
                                  ? FontWeight.w500
                                  : FontWeight.w400,
                              letterSpacing: 3,
                              color: brightness == BrightnessOption.light
                                  ? Colors.blue
                                  : Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            readOnly: loader,
                            controller: referralCodeController,
                            cursorColor: Colors.amber,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: 'Referral Code',
                              hintText: 'Enter Referral Code',
                              labelStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey[700],
                              ),
                              hintStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey[700],
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                borderSide: new BorderSide(
                                  width: 2,
                                  color: Colors.black,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                borderSide: new BorderSide(
                                    width: 2, color: Colors.grey[200]),
                              ),
                              suffixIcon: Icon(
                                Icons.screen_share,
                                color: brightness == BrightnessOption.light
                                    ? Colors.grey[300]
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (user.referralAvailed == false)
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white
                      ),
                      child: Image.asset('assets/images/referral.gif',
                        height: 300,
                        width: 300,
                      ),
                    ),
                  ),
                if (user.referralAvailed == false)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      width: double.infinity,
                      child: MaterialButton(
                          height: 50,
                          color: Colors.blue,
                          onPressed: !loader
                              ? () async {
                                  setState(() {
                                    loader = true;
                                  });
                                  print(referralCodeController.text);
                                  if (referralCodeController.text == null ||
                                      // ignore: unrelated_type_equality_checks
                                      referralCodeController.text == "") {
                                    createToast("Enter Referral Code");
                                  } else {
                                    final res = await availReferral(
                                        referralCodeController.text, user.uid);
                                    if (res == true) {
                                      Provider.of<UserProvider>(context,
                                              listen: false)
                                          .updateData2(coins: 100, referral: true);
                                    }
                                  }
                                  setState(() {
                                    loader = false;
                                  });
                                }
                              : () {},
                          child: !loader
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Avail Referral Code',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        letterSpacing: 3,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              : SpinKitCircle(
                                  color: Colors.white,
                                ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.white,
                                width: 2,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                    ),
                  ),
                if (user.referralAvailed == true)
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                            "Referral Code Already Availed.",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: brightness == BrightnessOption.light
                                  ? FontWeight.w500
                                  : FontWeight.w400,
                              letterSpacing: 2,
                              color: brightness == BrightnessOption.light
                                  ? Colors.blue
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (user.referralAvailed == true)
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[100]
                      ),
                      child: Image.asset('assets/images/referral_availed.gif',
                        height: 300,
                        width: 300,
                      ),
                    ),
                  ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 16), child: Divider()),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Share Your Referral Code",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: brightness == BrightnessOption.light
                        ? FontWeight.w500
                        : FontWeight.w400,
                    letterSpacing: 2,
                    color: brightness == BrightnessOption.light
                        ? Colors.blue
                        : Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Spacer(),
                    FlatButton(
                      onPressed: () {},
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white,
                                style: BorderStyle.solid,
                                width: 2),
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 15),
                            child: Text("Your Referral Code: " + user.referralCode,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          )),
                    ),
                    FittedBox(
                      child: FloatingActionButton(
                          child: Icon(
                            Icons.share,
                            size: 27,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.blue,
                          onPressed: () {
                            Share.share(
                                'Download Paradox from https://play.google.com/store/apps/details?id=com.exe.paradoxplay and use my referral code: ${user.referralAvailed} and earn 50 coins.');
                          },
                      ),
                    ),
                    Spacer(),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
          duration: Duration(milliseconds: 1000),
          builder: (ctx, value, child) {
            return ShaderMask(
              shaderCallback: (rect) {
                return RadialGradient(
                    colors: [
                      Colors.white,
                      Colors.white,
                      Colors.transparent,
                      Colors.transparent
                    ],
                    radius: value * 5,
                    stops: [0.0, .55, .66, 1.0],
                    center: FractionalOffset(.1, .6)
                ).createShader(rect);
              },
              child: child,
            );
          },
        ),
      ),
    );
  }
}

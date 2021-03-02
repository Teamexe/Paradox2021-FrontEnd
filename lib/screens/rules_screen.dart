import 'package:flutter/material.dart';
import 'package:paradox/screens/home_screen.dart';

class RulesScreen extends StatelessWidget {
  static String routeName = '/rules_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Paradox Rules'),
        ),
        body: SingleChildScrollView(
          child: TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: 1.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    '1. Guess the answer of the image shown and submit it in the result.\n\n'
                    '2. Register as early as possible to maximize your chances of winning the event.\n\n'
                    '3. Download our Paradox App to generate your referral code and earn coins by referring'
                    ' our app to your friends. You and your friend will be awarded 100 coins for using your referral code.\n\n'
                    '4. Coins are earned on every successful submission and are used to unlock hints. Initially each user gets 100 coins'
                    ' and 100 coins on successful submissions of answers.\n\n'
                    '5. Easy, Medium, Hard for categories for nimbus \n\n'
                    '6. No negative points on wrong attempts.\n\n'
                    '7. The answers are case insensitive i.e. you can also answer using camel case.\n\n'
                    '8. The answer can have one or more words separated by space.\n\n'
                    '9. For any query regarding the event, feel free to contact at teamexenith@ac.in',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(Home.routeName);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Let\'s Play',
                            style:
                                TextStyle(color: Colors.white, fontSize: 22)),
                      )),
                )
              ],
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
                            center: FractionalOffset(.1, .6))
                        .createShader(rect);
                  },
                  child: child);
            },
          ),
        ));
  }
}

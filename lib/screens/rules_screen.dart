import 'package:flutter/material.dart';

class RulesScreen extends StatelessWidget {
  static String routeName = '/rules_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paradox Rules'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                '1. Guess the answer of the image shown and submit it in the result.\n\n'
                '2. Register as early as possible to maximize your chances of winning the event.\n\n'
                '3. Download our Paradox App to generate your referral code and earn coins by referring'
                    ' our app to your friends. Maximum 5 friends can use your referral code and you will be awarded 2 points'
                    ' for each successful referral and your friend will be awarded 50 coins for using your referral code.\n\n'
                '4. Coins are earned on every successful submission and are used to unlock hints. Initially each user gets 100 coins'
                    ' and 60 coins on successful submissions of answers.\n\n'
                '5. The score and coins of Nimbus and Worldwide are completely independent of each other and'
                    ' increase on playing their respective games i.e. Easy, Medium, Hard for Nimbus and Paradox Play for worldwide.\n\n'
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
            Container(
              color: Colors.blue,
              child: FlatButton(
                child: Text('Let\'s Play', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
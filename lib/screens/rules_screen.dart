import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:paradox/providers/theme_provider.dart';
import 'package:paradox/screens/home_screen.dart';
import 'package:paradox/widgets/no_data_connection.dart';
import 'package:paradox/screens/question_screen.dart';
import 'package:provider/provider.dart';

class RulesScreen extends StatelessWidget {
  static String routeName = '/rules_screen';

  @override
  Widget build(BuildContext context) {
    final brightness = Provider.of<ThemeProvider>(context, listen: true).brightnessOption;

    return Scaffold(
        appBar: AppBar(
          title: Text('Paradox Rules'.toUpperCase(),
            style: TextStyle(
              letterSpacing: 2,
              fontWeight: brightness == BrightnessOption.dark ? FontWeight.w300 : FontWeight.w400,
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
        body: Stack(
          children: [
            AbsorbPointer(
              absorbing: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected ? true : false,
              child: Opacity(
                opacity: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected ? 0.2 : 1,
                child: SingleChildScrollView(
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
                            '5. Easy, Medium, Hard are the categories for nimbus. \n\n'
                            '6. No negative points on wrong attempts.\n\n'
                            '7. The answers are case insensitive i.e. you can also answer using camel case.\n\n'
                            '8. The answer can have one or more words separated by space.\n\n'
                            '9. For any query regarding the event, feel free to contact at teamexenith@ac.in',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(Home.routeName);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                                child: Text('Let\'s Play',
                                    style:
                                        TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400, letterSpacing: 2)),
                              )),
                        ),
                        SizedBox(height: 40)
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
                ),
              ),),
                SizedBox(height: 20),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(QuestionScreen.routeName);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                        child: Text('Let\'s Play',
                            style:
                                TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400, letterSpacing: 2)),
                      )),
                ),
                SizedBox(height: 40),
                Visibility(
                  visible: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected,
                  child: NoDataConnectionWidget(),
                ),
              ],
            ),
          );
  }
}

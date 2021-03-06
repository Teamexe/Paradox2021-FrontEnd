import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:paradox/providers/theme_provider.dart';
import 'package:paradox/providers/user_provider.dart';
import 'package:paradox/utilities/myBehaviour.dart';
import 'package:paradox/providers/question_provider.dart';
import 'package:paradox/widgets/hint_fab.dart';
import 'package:paradox/widgets/question_display.dart';
import 'package:provider/provider.dart';
import '../widgets/question_screen_layout.dart';

class QuestionScreen extends StatefulWidget {
  static String routeName = '/question_page';

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {

  @override
  Widget build(BuildContext context) {
    final questList = Provider.of<QuestionProvider>(context).questionList;
    final loading = Provider.of<QuestionProvider>(context).loaded;
    final loadingHints = Provider.of<QuestionProvider>(context).loadedHints;
    final level = Provider.of<UserProvider>(context).user.level;
    final loadedUser = Provider.of<UserProvider>(context).loadedProfile;
    final brightness = Provider.of<ThemeProvider>(context).brightnessOption;

    print(Provider.of<UserProvider>(context).user.hintLevel);
    print(questList);
    if (loading == false || loadingHints == false || loadedUser == false) {
      return Center(
          child: Container(
        child: Text("Loading"),
      ));
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: brightness == BrightnessOption.light
            ? Color(0xff0083B0)
            : Colors.grey[900],
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              brightness == BrightnessOption.light
                  ? Color(0xff0083B0)
                  : Colors.grey[900],
              brightness == BrightnessOption.light
                  ? Color(0xff00B4DB)
                  : Colors.grey[900],
              // Color(0xff1A2980),
            ], begin: Alignment.topCenter, end: Alignment.bottomRight),
            boxShadow: [
              BoxShadow(
                color: Color(0xff0083B0),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: questList.isEmpty
              ? SpinKitCircle(
                  color: Colors.white,
                )
              : QuestionDisplay(
                  questList: questList,
                  level: level,
                ),
        ),
      ),
      floatingActionButton: HintsFab(),
    );
  }
}

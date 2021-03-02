import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paradox/providers/user_provider.dart';
import 'package:paradox/utilities/myBehaviour.dart';
import 'package:paradox/providers/question_provider.dart';
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
    print(Provider.of<UserProvider>(context).user.hintLevel);
    print(questList);
    if (loading == false || loadingHints == false || loadedUser == false) {
      return Center(
          child: Container(
            child: Text("Loading"),
      ));
    }
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff0083B0),
              Color(0xff00B4DB),
              // Color(0xff1A2980),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
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
              : QuestionPageLayout(
                  questList: questList,
                  level: level,
                ),
        ),
      ),
      bottomNavigationBar: Container(
        // alignment: Alignment.topLeft,
        height: 40,
        decoration:BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff00A9D3),
            Color(0xff00B4DB),
            // Color(0xff1A2980),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ) ,

        child: IconButton(
          icon: Icon(Icons.keyboard_arrow_down_sharp),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

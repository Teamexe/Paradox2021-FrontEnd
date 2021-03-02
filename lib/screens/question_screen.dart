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
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF172339),
                  const Color(0xFF1a2840),
                  const Color(0xFF20324d),
                  const Color(0xFF1d2d46),
                  const Color(0xFF233754),
                  const Color(0xFF253a59),
                  const Color(0xFF273e5d),
                  const Color(0xFF294162),
                  const Color(0xFF2a4465),
                  const Color(0xFF2c4669),
                  const Color(0xFF2d496c),
                  const Color(0xFF2e4c70),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: level < questList.length
                ? questList.isEmpty
                    ? SpinKitCircle(
                        color: Colors.white,
                      )
                    : QuestionPageLayout(
                        questList: questList,
                        level: level,
                      )
                : Container(
                    color: Colors.transparent,
                  )),
      ),
      bottomNavigationBar: Container(
        // alignment: Alignment.topLeft,
        height: 40,
        color: const Color(0xFF172339),
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

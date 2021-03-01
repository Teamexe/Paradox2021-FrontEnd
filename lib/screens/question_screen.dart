import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paradox/utilities/myBehaviour.dart';
import 'package:paradox/providers/question_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/question_screen_layout.dart';

class QuestionScreen extends StatelessWidget {
  static String routeName = '/question_page';
  @override
  Widget build(BuildContext context) {
    final questList = Provider.of<QuestionProvider>(context).questionList;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: Container(
          height: MediaQuery.of(context).size.height *1,
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
          child:questList.isEmpty
              ? SpinKitCircle(
            color: Colors.white,
          )
              : QuestionPageLayout(questList)
        ),
      ),
      bottomNavigationBar: Container(
        // alignment: Alignment.topLeft,
        height: 40,
        color:  const Color(0xFF172339),
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

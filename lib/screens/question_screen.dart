import 'package:flutter/material.dart';
import '../widgets/question_screen_layout.dart';


class QuestionScreen extends StatelessWidget {
  static String routeName = '/question_page';
   @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.transparent,
    resizeToAvoidBottomInset:false,
      body: Container(
        height: double.infinity,
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
        ),),
        child: QuestionPageLayout(),
      ),
    );
  }
}

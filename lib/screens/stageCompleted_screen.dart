import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class StageCompleted extends StatelessWidget {
  static const routeName = '/stageCompletedScreen';

  @override
  Widget build(BuildContext context) {
    final brightness = Provider.of<ThemeProvider>(context).brightnessOption;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: brightness == BrightnessOption.light
                  ? [
                      Color(0xff0083B0),
                      Color(0xff00B4DB),
                      // Color(0xff1A2980),
                    ]
                  : [Colors.black54, Colors.black54],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          boxShadow: [
            BoxShadow(
              color: Color(0xff0083B0),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Container(
              height: size.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 15,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: Image.asset("assets/images/correct.gif"),
                  ),
                  Text(
                    "  “You have completed this Stage!”",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.blue[600],
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

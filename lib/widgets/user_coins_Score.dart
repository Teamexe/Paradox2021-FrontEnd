import 'package:flutter/material.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:paradox/providers/theme_provider.dart';
import 'package:paradox/providers/user_provider.dart';
import 'package:provider/provider.dart';


class UserStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final brightness = Provider.of<ThemeProvider>(context).brightnessOption;

    return  Padding(
      padding: const EdgeInsets.only(
          left: 20, right: 20, top: 0, bottom: 18),
      child: Container(
        margin: EdgeInsets.only(top:20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: brightness == BrightnessOption.dark
              ? Colors.grey
              : Colors.white,
        ),
        height: 72,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(
                "assets/images/badge.png",
                height: 40,
              ),
              Text(
                "Coins " + user.coins.toString(),
                style: TextStyle(
                  letterSpacing: 1,
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  color: brightness == BrightnessOption.dark
                      ? Colors.white
                      : Colors.black,
                ),
                maxLines: 2,
              ),
              SizedBox(width: 30,),
              Image.asset(
                "assets/images/trophy.png",
                height: 50,
              ),
              Text(
                "Score " + user.score.toString(),
                style: TextStyle(
                  letterSpacing: 1,
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  color: brightness == BrightnessOption.dark
                      ? Colors.white
                      : Colors.black,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

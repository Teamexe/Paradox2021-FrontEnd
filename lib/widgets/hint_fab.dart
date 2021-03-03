import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:paradox/providers/question_provider.dart';
import 'package:paradox/providers/theme_provider.dart';
import 'package:paradox/providers/user_provider.dart';
import 'package:provider/provider.dart';



class HintsFab extends StatefulWidget {

  @override
  _HintsFabState createState() => _HintsFabState();
}

class _HintsFabState extends State<HintsFab> {
  @override
  Widget build(BuildContext context) {
    final brightness = Provider.of<ThemeProvider>(context).brightnessOption;
    final hintList = Provider.of<QuestionProvider>(context).hintsList;
    final user = Provider.of<UserProvider>(context).user;
    return BoomMenu(
      foregroundColor: brightness == BrightnessOption.dark
          ? Colors.white
          : Colors.black,
        backgroundColor:  brightness == BrightnessOption.dark
            ? Colors.black
            : Colors.white,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        //child: Icon(Icons.add),
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        scrollVisible: true,
        overlayColor: Colors.black,
        overlayOpacity: 0.7,
        children: [
          MenuItem(
            child: Icon(Icons.lightbulb_outline, color: Colors.black),
            title: "Hint 1",
            titleColor: Colors.black,
            subtitle: "Avail hint 1 with 20 coins",
            subTitleColor: Colors.black,
            backgroundColor: Colors.white,
            onTap: () => print('FIRST CHILD'),
          ),
          MenuItem(
            child: Icon(Icons.lightbulb_outline, color: Colors.black),
            title: "Hint 2",
            titleColor: Colors.black,
            subtitle: "Avail hint 2 with 30 coins",
            subTitleColor: Colors.black,
            backgroundColor: Colors.white,
            onTap: () => print('SECOND CHILD'),
          ),
          MenuItem(
            child: Icon(Icons.lightbulb_outline, color: Colors.black),
            title: "Hint 3",
            titleColor: Colors.black,
            subtitle: "Avail hint 3 with 40 coins",

            subTitleColor: Colors.black,
            backgroundColor: Colors.white,
            onTap: () => print('THIRD CHILD'),
          ),

        ],
    );
  }
}

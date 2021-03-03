import 'package:flutter/material.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:paradox/models/leaderBoardUser.dart';
import 'package:paradox/providers/theme_provider.dart';
import 'package:paradox/screens/photo_view.dart';
import 'package:provider/provider.dart';

class UserCardWidget extends StatelessWidget {
  final LeaderBoardUser user;
  final int index;

  UserCardWidget(this.user, this.index);

  @override
  Widget build(BuildContext context) {
    final brightness = Provider.of<ThemeProvider>(context, listen: true).brightnessOption;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Expanded(
              child: Center(
                  child: Text(
                    '$index',
                    style: TextStyle(
                      color: brightness == BrightnessOption.light ? Color(0xff0083B0) : Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        brightness == BrightnessOption.light ? Color(0xff0083B0) : Colors.white.withOpacity(0.9),
                        brightness == BrightnessOption.light ? Color(0xff00B4DB) : Colors.grey[400],
                        // Color(0xff1A2980),
                      ],
                    ),
                    boxShadow: [
                      brightness == BrightnessOption.light ?
                      BoxShadow(
                        color: Color(0xff0083B0),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      )
                      : BoxShadow(),
                    ],
                    borderRadius: BorderRadius.circular(35)),
                child: Row(
                  children: [
                    GestureDetector(
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.transparent,
                        child: CircleAvatar(
                          backgroundImage: new NetworkImage(user.image),
                          radius: 33,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) =>
                                ExpandedImageView(image: user.image)));
                      },
                    ),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                          user.name,
                          style: TextStyle(color: brightness == BrightnessOption.light ? Colors.white : Colors.grey[800]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Text(
                        user.score.toString(),
                        style: TextStyle(color: brightness == BrightnessOption.light ? Colors.white : Colors.grey[800]),
                      ),
                    )
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:paradox/models/leaderBoardUser.dart';
import 'package:paradox/providers/theme_provider.dart';
import 'package:paradox/screens/photo_view.dart';
import 'package:provider/provider.dart';

class PlayerCard extends StatelessWidget {
  final LeaderBoardUser user;
  final int index;

  PlayerCard(this.user, this.index);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);

    return Container(
      width: 160,
      child: Card(
        color: themeProvider.brightness == BrightnessOption.light
            ? Colors.grey[300]
            : Colors.grey[400],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: themeProvider.brightness == BrightnessOption.light
              ? Colors.white
              : Colors.white54,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Container(
                    width: 60,
                    height: 60,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.blue.withOpacity(0.85),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image(
                          image: NetworkImage(user.image),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Align(
                  child: Text(user.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue.withOpacity(0.85))),
                ),
                SizedBox(height: 5),
                Container(
                  child: Text('nimbus'.toUpperCase(),
                      style: TextStyle(color: Colors.grey[400])),
                ),
                SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.blue.withOpacity(0.83),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        children: [
                          TextSpan(text: 'Score'),
                          TextSpan(text: '  '),
                          TextSpan(
                            text: user.score.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

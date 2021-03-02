import 'package:flutter/material.dart';
import 'package:paradox/models/leaderBoardUser.dart';
import 'package:paradox/screens/photo_view.dart';

class UserCardWidget extends StatelessWidget {
  final LeaderBoardUser user;
  final int index;

  UserCardWidget(this.user, this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      child: Row(
        children: [
          Expanded(
              child: Center(
                  child: Text(
            '$index',
            style: TextStyle(
                color: Colors.blue[700],
                fontSize: 26,
                fontWeight: FontWeight.w600),
          ))),
          Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff0083B0),
                        Color(0xff00B4DB),
                        // Color(0xff1A2980),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff0083B0),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(35)),
                child: Row(
                  children: [
                    GestureDetector(
                      child: CircleAvatar(
                        backgroundImage: new NetworkImage(user.image),
                        radius: 35,
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
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Text(
                        user.score.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

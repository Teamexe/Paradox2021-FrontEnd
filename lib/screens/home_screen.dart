import 'package:flutter/material.dart';
import 'package:paradox/providers/user_provider.dart';
import 'package:paradox/screens/user_profile_screen.dart';
import 'package:paradox/widgets/drawer.dart';

class Home extends StatelessWidget {
  static String routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paradox'),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: FlatButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image(
                  image: NetworkImage(UserProvider().getUserProfileImage()),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, ProfileScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
    );
  }
}


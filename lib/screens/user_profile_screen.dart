import 'package:flutter/material.dart';
import 'package:paradox/providers/user_provider.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = '/user_profile_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image(
                    image: NetworkImage(UserProvider().getUserProfileImage()),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      child: Text(UserProvider().getUserName()),
                    ),
                    Container(
                      child: Text(UserProvider().getUserEmail()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
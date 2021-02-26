import 'package:flutter/material.dart';
import 'package:paradox/providers/user_provider.dart';

AppBar appBar = AppBar(
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

        },
      ),
    ),
  ],
);
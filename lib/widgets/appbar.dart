import 'package:flutter/material.dart';
import 'package:paradox/providers/user_provider.dart';
import 'package:paradox/utilities/Toast.dart';

AppBar appBar = AppBar(
  title: Text('Paradox'.toUpperCase()),
  actions: [
    IconButton(
      icon: Icon(Icons.logout),
      onPressed: () {
        UserProvider().logout();
        createToast('Signed Out Successfully');
      },
    ),
  ],
);
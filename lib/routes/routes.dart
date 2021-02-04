import 'package:flutter/widgets.dart';
import '../authentication/sign_in.dart';
import '../screens/home_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {

  SignIn.routeName: (context) => SignIn(),
  Home.routeName: (context) => Home()

};
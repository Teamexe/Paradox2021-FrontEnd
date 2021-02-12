import 'package:flutter/cupertino.dart';

/// Model for Hints used in particular Question
class Hint {
  int level;
  String hint1;
  String hint2;
  String hint3;

  Hint(
      {@required this.level,
      @required this.hint1,
      @required this.hint2,
      @required this.hint3});
}

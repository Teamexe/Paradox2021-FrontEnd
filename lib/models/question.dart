import 'package:flutter/foundation.dart';

/// Question
class Question {
  int level;
  String location;   /// Image Url\
  String difficulty;
  Question({@required this.level,@required this.location, @required this.difficulty});
}
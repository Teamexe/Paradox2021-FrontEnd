import 'package:flutter/cupertino.dart';

class ExeMemberProfile {
  // Model for exe members details.
  int id;
  String name;
  String position;
  String category;
  String image;
  String githubUrl;
  String linkedInUrl;

  ExeMemberProfile(
      {@required this.id,
      @required this.name,
      @required this.position,
      @required this.category,
      @required this.image,
      @required this.githubUrl,
      @required this.linkedInUrl});
}

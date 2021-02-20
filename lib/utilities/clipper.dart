import 'package:flutter/material.dart';

class CustomizedClipper extends CustomClipper<Path>{

  Path _getClip(Size size){
    Path path = new Path();
    path.lineTo(0, size.height * 0.54);
    path.cubicTo(0, size.height * 0.54, size.width * 0.06, size.height * 0.62, size.width * 0.06, size.height * 0.62);
    path.cubicTo(size.width * 0.11, size.height * 0.71, size.width * 0.22, size.height * 0.89, size.width / 3, size.height * 0.96);
    path.cubicTo(size.width * 0.44, size.height * 1.03, size.width * 0.56, size.height, size.width * 0.67, size.height * 0.87);
    path.cubicTo(size.width * 0.78, size.height * 0.75, size.width * 0.89, size.height * 0.54, size.width * 0.94, size.height * 0.43);
    path.cubicTo(size.width * 0.94, size.height * 0.43, size.width, size.height * 0.32, size.width, size.height * 0.32);
    path.cubicTo(size.width, size.height * 0.32, size.width, 0, size.width, 0);
    path.cubicTo(size.width, 0, size.width * 0.94, 0, size.width * 0.94, 0);
    path.cubicTo(size.width * 0.89, 0, size.width * 0.78, 0, size.width * 0.67, 0);
    path.cubicTo(size.width * 0.56, 0, size.width * 0.44, 0, size.width / 3, 0);
    path.cubicTo(size.width * 0.22, 0, size.width * 0.11, 0, size.width * 0.06, 0);
    path.cubicTo(size.width * 0.06, 0, 0, 0, 0, 0);
    path.cubicTo(0, 0, 0, size.height * 0.54, 0, size.height * 0.54);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

  @override
  Path getClip(Size size) => _getClip(size);
}
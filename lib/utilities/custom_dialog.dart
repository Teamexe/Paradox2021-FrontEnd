import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paradox/utilities/logo_painter.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, description;
  CustomDialogBox(this.title, this.description);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  Color borderColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(4),
          margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: borderColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.grey, offset: Offset(0, 0), blurRadius: 10),
              ]
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                // boxShadow: [
                //   BoxShadow(color: Colors.grey, offset: Offset(0, 10), blurRadius: 10),
                // ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25, color: Colors.blue.shade600), textAlign: TextAlign.center,),
                SizedBox(height: 22),
                Text(widget.description, style: TextStyle(fontSize: 14, color: Colors.grey.shade600), textAlign: TextAlign.center,),
              ],
            ),
          ),
        ),
        Positioned(
            left: 20,
            right: 20,
            child: CircleAvatar(
              backgroundColor: borderColor,
              radius: 40,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 36,
                child: Transform.rotate(
                  angle: pi / 3,
                  child: Container(
                    width: 30,
                    height: 30,
                    margin: EdgeInsets.all(10),
                    child: CustomPaint(
                      painter: MyLogoPainter(Colors.blue),
                      child: Container(),
                    ),
                  ),
                ),
              ),
            ),
        ),
      ],
    );
  }
}

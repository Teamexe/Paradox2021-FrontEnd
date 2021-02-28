import 'package:flutter/material.dart';
import 'package:paradox/utilities/type_writer_text.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class TypeWriterBox extends StatefulWidget {
  final String text;
  TypeWriterBox(this.text);

  @override
  _TypeWriterBoxState createState() => _TypeWriterBoxState();
}

class _TypeWriterBoxState extends State<TypeWriterBox> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PlayAnimation<double>(
        duration: Duration(milliseconds: 400),
        tween: 0.0.tweenTo(80.0),
        builder: (context, child, height) {
          return PlayAnimation<double>(
              duration: Duration(milliseconds: 400),
              delay: 500.milliseconds,
              builder: (context, child, width) {
                return Container(
                  width: width,
                  height: height,
                  child: typewriter(width) ? TypeWriterText(widget.text) : Container(),
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.85),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withAlpha(50),
                            blurRadius: 15,
                            offset: Offset(0, 8),
                            spreadRadius: 5
                        )
                      ]
                  ),
                );
              },
              tween: 2.0.tweenTo(300.0));
        },
      ),
    );
  }

  bool typewriter(double width) {
    return width > 15;
  }
}
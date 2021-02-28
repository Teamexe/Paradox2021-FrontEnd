import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class TypeWriterText extends StatefulWidget {
  final String text;
  TypeWriterText(this.text);

  @override
  _TypeWriterTextState createState() => _TypeWriterTextState();
}

class _TypeWriterTextState extends State<TypeWriterText> {
  @override
  Widget build(BuildContext context) {
    return PlayAnimation<int>(
      duration: 1000.milliseconds,
      delay: 1000.milliseconds,
      tween: 0.tweenTo(widget.text.length),
      builder: (context, child, textLength) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.text.substring(0, textLength),
              style: TextStyle(letterSpacing: 2, fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white)),
            // blinkingCursor(),
          ],
        );
      },
    );
  }

  // Widget blinkingCursor() {
  //   return LoopAnimation<int>(
  //     duration: 800.milliseconds,
  //     builder: (context, child, oneOrZero) {
  //       return Opacity(
  //         opacity: oneOrZero == 1 ? 1.0 : 0.0,
  //         child: Text('_', style: TextStyle(letterSpacing: 5, fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white)),
  //       );
  //     },
  //     tween: 0.tweenTo(1),
  //   );
  // }
}
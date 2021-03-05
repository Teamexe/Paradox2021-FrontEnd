import 'package:flutter/material.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:paradox/providers/theme_provider.dart';
import 'package:paradox/utilities/type_writer_text.dart';
import 'package:provider/provider.dart';
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
    final brightness = Provider.of<ThemeProvider>(context).brightnessOption;

    return Center(
      child: PlayAnimation<double>(
        duration: Duration(milliseconds: 400),
        tween: 0.0.tweenTo(80.0),
        builder: (context, child, height) {
          return PlayAnimation<double>(
              duration: Duration(milliseconds: 400),
              builder: (context, child, width) {
                return Container(
                  width: width,
                  height: height,
                  child: typewriter(width)
                      ? TypeWriterText(widget.text)
                      : Container(),
                  decoration: BoxDecoration(
                      color: brightness == BrightnessOption.dark
                          ? Colors.grey.shade700
                          : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color: brightness == BrightnessOption.light
                              ? Colors.blue
                              : Colors.grey,
                          width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: brightness == BrightnessOption.light
                              ? Colors.grey.shade300
                              : Colors.grey.withAlpha(50),
                          blurRadius: 15,
                          offset: Offset(0, 8),
                          spreadRadius:
                              brightness == BrightnessOption.light ? 5 : 2,
                        )
                      ]),
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

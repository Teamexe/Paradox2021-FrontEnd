import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:paradox/providers/theme_provider.dart';
import 'package:paradox/utilities/circle_painter.dart';
import 'package:provider/provider.dart';

class RippleAnimation extends StatefulWidget {
  final double size;
  final Widget child;
  RippleAnimation(this.size, this.child);

  @override
  _RippleAnimationState createState() => _RippleAnimationState();
}

class _RippleAnimationState extends State<RippleAnimation> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: Duration(milliseconds: 2000),
        vsync: this
    )..repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _animationController.stop();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Provider.of<ThemeProvider>(context).brightnessOption;

    return SafeArea(
      child: Container(
        child: Center(
          child: CustomPaint(
            painter: CirclePainter(
              _animationController,
              color: brightness == BrightnessOption.light ? Colors.blue : Colors.white,
            ),
            child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(widget.size),
                  child: widget.child
                ),
            ),
          ),
        ),
      ),
    );
  }
}
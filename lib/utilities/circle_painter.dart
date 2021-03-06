import 'package:flutter/cupertino.dart';
import 'dart:math';

class CirclePainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;
  CirclePainter(this.animation, {
    @required this.color
  }) : super (repaint: animation);

  void circle(Canvas canvas, Rect rect, double value) {
    final double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final Color _color = color.withOpacity(opacity);
    final double size = rect.width / 2;
    final double area = size * size;
    final double radius = sqrt(area * value / 4);
    final Paint paint = Paint()..color = _color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + animation.value);
    }
  }
  @override
  bool shouldRepaint(CirclePainter oldDelegate) => true;

}
import 'package:flutter/material.dart';

class MyLogoPainter extends CustomPainter {
  final Color customColor;
  MyLogoPainter(this.customColor);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = customColor;
    path = Path();
    path.lineTo(size.width * 0.47, size.height * 1.17);
    path.cubicTo(size.width * 0.47, size.height * 1.17, size.width * 0.45, size.height * 1.14, size.width * 0.43, size.height * 1.1);
    path.cubicTo(size.width * 0.39, size.height * 1.03, size.width * 0.3, size.height * 0.85, size.width * 0.23, size.height * 0.7);
    path.cubicTo(size.width * 0.19, size.height * 0.64, size.width * 0.17, size.height * 0.59, size.width * 0.16, size.height * 0.58);
    path.cubicTo(size.width * 0.13, size.height * 0.52, size.width * 0.11, size.height * 0.49, size.width * 0.1, size.height * 0.47);
    path.cubicTo(size.width * 0.1, size.height * 0.46, size.width * 0.08, size.height * 0.43, size.width * 0.07, size.height * 0.41);
    path.cubicTo(size.width * 0.03, size.height * 0.34, 0, size.height * 0.28, 0, size.height * 0.28);
    path.cubicTo(0, size.height * 0.28, 0, size.height * 0.28, 0, size.height * 0.28);
    path.cubicTo(0, size.height * 0.27, size.width * 0.09, size.height * 0.27, size.width * 0.39, size.height * 0.27);
    path.cubicTo(size.width * 0.74, size.height * 0.27, size.width * 0.77, size.height * 0.27, size.width * 0.77, size.height * 0.27);
    path.cubicTo(size.width * 0.77, size.height * 0.28, size.width * 0.72, size.height * 0.38, size.width * 0.72, size.height * 0.38);
    path.cubicTo(size.width * 0.71, size.height * 0.39, size.width * 0.7, size.height * 0.39, size.width * 0.65, size.height * 0.39);
    path.cubicTo(size.width * 0.6, size.height * 0.38, size.width / 5, size.height * 0.38, size.width * 0.18, size.height * 0.38);
    path.cubicTo(size.width * 0.17, size.height * 0.38, size.width * 0.17, size.height * 0.37, size.width / 5, size.height * 0.44);
    path.cubicTo(size.width * 0.22, size.height * 0.46, size.width * 0.23, size.height * 0.48, size.width * 0.23, size.height * 0.49);
    path.cubicTo(size.width * 0.23, size.height * 0.49, size.width * 0.24, size.height / 2, size.width * 0.24, size.height * 0.51);
    path.cubicTo(size.width / 4, size.height * 0.52, size.width * 0.28, size.height * 0.59, size.width * 0.32, size.height * 0.66);
    path.cubicTo(size.width * 0.36, size.height * 0.74, size.width * 0.41, size.height * 0.84, size.width * 0.44, size.height * 0.89);
    path.cubicTo(size.width * 0.48, size.height * 0.97, size.width * 0.52, size.height * 1.04, size.width * 0.56, size.height * 1.12);
    path.cubicTo(size.width * 0.57, size.height * 1.14, size.width * 0.58, size.height * 1.16, size.width * 0.58, size.height * 1.17);
    path.cubicTo(size.width * 0.58, size.height * 1.17, size.width * 0.57, size.height * 1.17, size.width * 0.52, size.height * 1.17);
    path.cubicTo(size.width / 2, size.height * 1.17, size.width * 0.48, size.height * 1.17, size.width * 0.48, size.height * 1.17);
    path.cubicTo(size.width * 0.48, size.height * 1.17, size.width * 0.47, size.height * 1.17, size.width * 0.47, size.height * 1.17);
    path.cubicTo(size.width * 0.47, size.height * 1.17, size.width * 0.47, size.height * 1.17, size.width * 0.47, size.height * 1.17);
    canvas.drawPath(path, paint);

    // Path number 2

    paint.color = customColor;
    path = Path();
    path.lineTo(size.width * 0.65, size.height * 1.16);
    path.cubicTo(size.width * 0.65, size.height * 1.16, size.width * 0.64, size.height * 1.15, size.width * 0.64, size.height * 1.13);
    path.cubicTo(size.width * 0.61, size.height * 1.08, size.width * 0.58, size.height * 1.03, size.width * 0.55, size.height * 0.98);
    path.cubicTo(size.width * 0.54, size.height * 0.95, size.width * 0.52, size.height * 0.92, size.width * 0.52, size.height * 0.91);
    path.cubicTo(size.width * 0.52, size.height * 0.91, size.width / 2, size.height * 0.88, size.width * 0.48, size.height * 0.85);
    path.cubicTo(size.width * 0.47, size.height * 0.82, size.width * 0.45, size.height * 0.79, size.width * 0.45, size.height * 0.78);
    path.cubicTo(size.width * 0.44, size.height * 0.77, size.width * 0.43, size.height * 0.76, size.width * 0.43, size.height * 0.75);
    path.cubicTo(size.width * 0.41, size.height * 0.71, size.width * 0.37, size.height * 0.64, size.width * 0.37, size.height * 0.63);
    path.cubicTo(size.width * 0.36, size.height * 0.61, size.width / 3, size.height * 0.57, size.width * 0.31, size.height * 0.52);
    path.cubicTo(size.width * 0.27, size.height * 0.46, size.width * 0.26, size.height * 0.44, size.width * 0.26, size.height * 0.43);
    path.cubicTo(size.width * 0.26, size.height * 0.43, size.width * 0.29, size.height * 0.43, size.width * 0.32, size.height * 0.43);
    path.cubicTo(size.width * 0.32, size.height * 0.43, size.width * 0.38, size.height * 0.43, size.width * 0.38, size.height * 0.43);
    path.cubicTo(size.width * 0.38, size.height * 0.43, size.width * 0.4, size.height * 0.47, size.width * 0.4, size.height * 0.47);
    path.cubicTo(size.width * 0.51, size.height * 0.67, size.width * 0.56, size.height * 0.78, size.width * 0.59, size.height * 0.82);
    path.cubicTo(size.width * 0.59, size.height * 0.83, size.width * 0.6, size.height * 0.85, size.width * 0.6, size.height * 0.86);
    path.cubicTo(size.width * 0.61, size.height * 0.86, size.width * 0.61, size.height * 0.87, size.width * 0.62, size.height * 0.88);
    path.cubicTo(size.width * 0.64, size.height * 0.93, size.width * 0.65, size.height * 0.94, size.width * 0.65, size.height * 0.94);
    path.cubicTo(size.width * 0.65, size.height * 0.94, size.width * 0.66, size.height * 0.92, size.width * 0.68, size.height * 0.9);
    path.cubicTo(size.width * 0.69, size.height * 0.87, size.width * 0.71, size.height * 0.84, size.width * 0.71, size.height * 0.83);
    path.cubicTo(size.width * 0.72, size.height * 0.81, size.width * 0.73, size.height * 0.79, size.width * 0.74, size.height * 0.78);
    path.cubicTo(size.width * 0.74, size.height * 0.77, size.width * 0.76, size.height * 0.73, size.width * 0.78, size.height * 0.7);
    path.cubicTo(size.width * 0.8, size.height * 0.66, size.width * 0.83, size.height * 0.61, size.width * 0.84, size.height * 0.59);
    path.cubicTo(size.width * 0.85, size.height * 0.57, size.width * 0.86, size.height * 0.54, size.width * 0.87, size.height * 0.52);
    path.cubicTo(size.width * 0.89, size.height * 0.49, size.width * 0.9, size.height * 0.48, size.width * 0.93, size.height * 0.41);
    path.cubicTo(size.width * 0.96, size.height * 0.35, size.width * 0.97, size.height * 0.34, size.width * 0.98, size.height * 0.32);
    path.cubicTo(size.width * 0.98, size.height * 0.32, size.width, size.height * 0.31, size.width, size.height * 0.31);
    path.cubicTo(size.width, size.height * 0.31, size.width, size.height * 0.3, size.width, size.height * 0.29);
    path.cubicTo(size.width, size.height * 0.27, size.width * 1.02, size.height * 0.24, size.width * 1.04, size.height / 5);
    path.cubicTo(size.width * 1.05, size.height * 0.18, size.width * 1.07, size.height * 0.16, size.width * 1.07, size.height * 0.16);
    path.cubicTo(size.width * 1.07, size.height * 0.16, size.width * 1.07, size.height * 0.17, size.width * 1.08, size.height * 0.18);
    path.cubicTo(size.width * 1.08, size.height * 0.19, size.width * 1.1, size.height / 5, size.width * 1.11, size.height * 0.23);
    path.cubicTo(size.width * 1.12, size.height / 4, size.width * 1.13, size.height * 0.26, size.width * 1.13, size.height * 0.27);
    path.cubicTo(size.width * 1.13, size.height * 0.27, size.width * 1.12, size.height * 0.28, size.width * 1.11, size.height * 0.29);
    path.cubicTo(size.width * 1.11, size.height * 0.31, size.width * 1.09, size.height * 0.34, size.width * 1.08, size.height * 0.37);
    path.cubicTo(size.width * 1.06, size.height * 0.39, size.width * 1.04, size.height * 0.42, size.width * 1.04, size.height * 0.44);
    path.cubicTo(size.width * 1.03, size.height * 0.45, size.width * 1.02, size.height * 0.47, size.width, size.height * 0.48);
    path.cubicTo(size.width * 0.97, size.height * 0.56, size.width * 0.94, size.height * 0.62, size.width * 0.9, size.height * 0.69);
    path.cubicTo(size.width * 0.9, size.height * 0.7, size.width * 0.87, size.height * 0.76, size.width * 0.86, size.height * 0.77);
    path.cubicTo(size.width * 0.86, size.height * 0.78, size.width * 0.83, size.height * 0.82, size.width * 0.81, size.height * 0.87);
    path.cubicTo(size.width * 0.79, size.height * 0.91, size.width * 0.76, size.height * 0.97, size.width * 0.75, size.height);
    path.cubicTo(size.width * 0.74, size.height, size.width * 0.71, size.height * 1.05, size.width * 0.69, size.height * 1.09);
    path.cubicTo(size.width * 0.67, size.height * 1.13, size.width * 0.66, size.height * 1.16, size.width * 0.66, size.height * 1.16);
    path.cubicTo(size.width * 0.65, size.height * 1.16, size.width * 0.65, size.height * 1.16, size.width * 0.65, size.height * 1.16);
    path.cubicTo(size.width * 0.65, size.height * 1.16, size.width * 0.65, size.height * 1.16, size.width * 0.65, size.height * 1.16);
    canvas.drawPath(path, paint);

    // Path number 3

    paint.color = customColor;
    path = Path();
    path.lineTo(size.width * 0.65, size.height * 0.82);
    path.cubicTo(size.width * 0.64, size.height * 0.81, size.width * 0.63, size.height * 0.79, size.width * 0.62, size.height * 0.76);
    path.cubicTo(size.width * 0.62, size.height * 0.76, size.width * 0.59, size.height * 0.72, size.width * 0.59, size.height * 0.72);
    path.cubicTo(size.width * 0.59, size.height * 0.72, size.width * 0.6, size.height * 0.71, size.width * 0.6, size.height * 0.71);
    path.cubicTo(size.width * 0.6, size.height * 0.7, size.width * 0.6, size.height * 0.69, size.width * 0.61, size.height * 0.69);
    path.cubicTo(size.width * 0.61, size.height * 0.68, size.width * 0.62, size.height * 0.65, size.width * 0.64, size.height * 0.62);
    path.cubicTo(size.width * 0.66, size.height * 0.59, size.width * 0.7, size.height * 0.52, size.width * 0.73, size.height * 0.46);
    path.cubicTo(size.width * 0.76, size.height * 0.4, size.width * 0.79, size.height * 0.34, size.width * 0.8, size.height / 3);
    path.cubicTo(size.width * 0.81, size.height * 0.31, size.width * 0.82, size.height * 0.29, size.width * 0.83, size.height * 0.28);
    path.cubicTo(size.width * 0.85, size.height * 0.23, size.width * 0.86, size.height / 5, size.width * 0.86, size.height / 5);
    path.cubicTo(size.width * 0.86, size.height / 5, size.width * 0.67, size.height / 5, size.width * 0.45, size.height / 5);
    path.cubicTo(size.width * 0.06, size.height / 5, size.width * 0.04, size.height / 5, size.width * 0.04, size.height / 5);
    path.cubicTo(size.width * 0.04, size.height * 0.19, size.width * 0.08, size.height * 0.11, size.width * 0.09, size.height * 0.1);
    path.cubicTo(size.width * 0.09, size.height * 0.1, size.width * 0.09, size.height * 0.09, size.width * 0.09, size.height * 0.09);
    path.cubicTo(size.width * 0.09, size.height * 0.09, size.width * 0.56, size.height * 0.09, size.width * 0.56, size.height * 0.09);
    path.cubicTo(size.width * 0.82, size.height * 0.09, size.width * 1.03, size.height * 0.09, size.width * 1.04, size.height * 0.1);
    path.cubicTo(size.width * 1.04, size.height * 0.1, size.width * 1.03, size.height * 0.11, size.width * 1.03, size.height * 0.12);
    path.cubicTo(size.width * 1.02, size.height * 0.13, size.width * 0.9, size.height * 0.35, size.width * 0.89, size.height * 0.38);
    path.cubicTo(size.width * 0.89, size.height * 0.38, size.width * 0.86, size.height * 0.42, size.width * 0.84, size.height * 0.47);
    path.cubicTo(size.width * 0.82, size.height * 0.51, size.width * 0.78, size.height * 0.58, size.width * 0.76, size.height * 0.62);
    path.cubicTo(size.width * 0.74, size.height * 0.66, size.width * 0.73, size.height * 0.69, size.width * 0.72, size.height * 0.7);
    path.cubicTo(size.width * 0.72, size.height * 0.7, size.width * 0.7, size.height * 0.73, size.width * 0.68, size.height * 0.77);
    path.cubicTo(size.width * 0.67, size.height * 0.8, size.width * 0.65, size.height * 0.83, size.width * 0.65, size.height * 0.83);
    path.cubicTo(size.width * 0.65, size.height * 0.83, size.width * 0.65, size.height * 0.82, size.width * 0.65, size.height * 0.82);
    path.cubicTo(size.width * 0.65, size.height * 0.82, size.width * 0.65, size.height * 0.82, size.width * 0.65, size.height * 0.82);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


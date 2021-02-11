import 'package:flutter/material.dart';
import '../authentication/sign_in.dart';
import '../authentication/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatelessWidget {
  static String routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paradox'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              logout();
              Fluttertoast.showToast(
                  msg: 'Signed Out Successfully',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 15.0
              );
              Navigator.of(context).pushNamed(SignIn.routeName);
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: CustomPaint(
          painter: CurvePainter(),
          child: Container(),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.blue;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
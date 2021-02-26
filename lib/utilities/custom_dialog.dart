import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paradox/utilities/logo_painter.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptionText1, url1, descriptionText2, url2;
  final Color color;
  CustomDialogBox(this.title, this.descriptionText1, this.url1, this.descriptionText2, this.url2, this.color);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context, widget.color),
    );
  }

  contentBox(context, customColor) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(4),
          margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: customColor,
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
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25, color: Colors.blue.shade600), textAlign: TextAlign.center,),
                SizedBox(height: 22),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
                      children: [
                        TextSpan(text: widget.descriptionText1),
                        TextSpan(text: widget.url1,
                          style: TextStyle(fontSize: 15, color: Colors.blue, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            if (await canLaunch(widget.url1)) {
                              launch(widget.url1);
                            }
                          }
                        ),
                        TextSpan(text: widget.descriptionText2),
                        TextSpan(text: widget.url2,
                            style: TextStyle(fontSize: 15, color: Colors.blue, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            if (await canLaunch(widget.url2)) {
                              launch(widget.url2);
                            }
                          }
                        ),
                      ],
                    ),
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () async {
                            if (await canLaunch('mailto:teamexenith@gmail.com'))
                              launch('mailto:teamexenith@gmail.com');
                          },
                          child: Container(
                              child: Text('contact us'.toUpperCase(), style: TextStyle(color: Colors.grey, fontSize: 15))
                          )
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                          onTap: () async {
                            if (await canLaunch('https://docs.google.com/forms/d/e/1FAIpQLSdf7fcO6cUbLcHCt7uxJoOSeVY7eTxRCE25E_BKyPRzEyZMng/viewform'))
                              launch('https://docs.google.com/forms/d/e/1FAIpQLSdf7fcO6cUbLcHCt7uxJoOSeVY7eTxRCE25E_BKyPRzEyZMng/viewform');
                          },
                          child: Container(
                              child: Text('feedback'.toUpperCase(), style: TextStyle(color: Colors.grey, fontSize: 15))
                          ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                          onTap: () async {
                            if (await canLaunch('https://instagram.com/teamexenith?igshid=q1zcaikgc08s'))
                              launch('https://instagram.com/teamexenith?igshid=q1zcaikgc08s');
                          },
                          child: Container(child: Text('instagram'.toUpperCase(), style: TextStyle(color: Colors.grey, fontSize: 15))
                          ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
            left: 20,
            right: 20,
            child: CircleAvatar(
              backgroundColor: customColor,
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

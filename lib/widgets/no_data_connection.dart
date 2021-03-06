import 'dart:math';
import 'dart:ui';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:paradox/providers/theme_provider.dart';
import 'package:paradox/utilities/logo_painter.dart';
import 'package:paradox/utilities/ripple_animation.dart';
import 'package:provider/provider.dart';
import 'package:system_shortcuts/system_shortcuts.dart';

class NoDataConnectionWidget extends StatefulWidget {
  @override
  _NoDataConnectionWidgetState createState() => _NoDataConnectionWidgetState();
}

class _NoDataConnectionWidgetState extends State<NoDataConnectionWidget> {

  @override
  Widget build(BuildContext context) {
    final brightness = Provider.of<ThemeProvider>(context, listen: true).brightnessOption;
    Color customColor = brightness == BrightnessOption.light ? Colors.blue.withOpacity(0.85) : Colors.grey;

    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.fromLTRB(10, 40, 10, 10),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: customColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: brightness == BrightnessOption.dark ? Colors.white10 : Colors.grey, offset: Offset(0, 0), blurRadius: 10),
                    ]
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: brightness == BrightnessOption.light ? Colors.white : Colors.grey[900],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('No Internet'.toUpperCase(),
                          style: TextStyle(
                            fontWeight: brightness == BrightnessOption.dark ? FontWeight.w300 : FontWeight.w400,
                            fontSize: 22,
                            letterSpacing: 2,
                            color: brightness == BrightnessOption.light ? Colors.blue : Colors.white70,
                          ),
                          textAlign: TextAlign.center
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: RippleAnimation(MediaQuery.of(context).size.width * 0.6, imageWidget),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Text('You are not connected to internet'.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: brightness == BrightnessOption.light ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Text('please turn on'.toUpperCase(),
                          style: TextStyle(
                            fontWeight: brightness == BrightnessOption.dark ? FontWeight.w300 : FontWeight.w400,
                            fontSize: 16,
                            color: brightness == BrightnessOption.light ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              color: brightness == BrightnessOption.dark ? Colors.grey : Colors.blue,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: () async {
                                // TODO: turn on wifi
                                // await SystemShortcuts.checkWifi;
                              },
                              child: Text('WiFi',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                            MaterialButton(
                              color: brightness == BrightnessOption.dark ? Colors.grey : Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                // TODO: open settings app
                                // AppSettings.openDataRoamingSettings();
                              },
                              child: Text('Mobile Data',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
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
                    backgroundColor: brightness == BrightnessOption.light ? Colors.white : Colors.grey[850],
                    radius: 36,
                    child: Transform.rotate(
                      angle: pi / 3,
                      child: Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.all(10),
                        child: CustomPaint(
                          painter: MyLogoPainter(customColor),
                          child: Container(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageWidget = Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    width: 150,
    height: 150,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        image: AssetImage('assets/images/internet.jpg'),
        fit: BoxFit.fill,
      ),
      color: Colors.white,
    ),
  );

}
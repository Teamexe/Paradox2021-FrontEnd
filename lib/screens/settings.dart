import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:paradox/providers/theme_provider.dart';
import 'package:provider/provider.dart';

Map<BrightnessOption, Widget> options = {
  BrightnessOption.light: SlidingSegment(CupertinoIcons.sun_max_fill),
  BrightnessOption.dark: SlidingSegment(CupertinoIcons.moon_fill)
};

class SlidingSegment extends StatelessWidget {
  final IconData iconData;
  SlidingSegment(this.iconData);

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      size: 18,
      color: Colors.grey[400],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  static String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',
          style: TextStyle(color: Colors.white, letterSpacing: 2, fontWeight: FontWeight.w400),
        ),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      body: SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    BrightnessOption selectedOption = themeProvider.brightness;

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: null,
          margin: null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Text('Dark Mode',
                              style: TextStyle(color: selectedOption == BrightnessOption.light ? Colors.blue : Colors.white , letterSpacing: 3, fontWeight: FontWeight.w400, fontSize: 16),
                            )
                        ),
                        CupertinoSlidingSegmentedControl<BrightnessOption>(
                          children: options,
                          groupValue: selectedOption,
                          backgroundColor: Colors.grey[100].withOpacity(0.5),
                          onValueChanged: (BrightnessOption selectedValue) {
                            setState(() {
                              selectedOption = selectedValue;
                              themeProvider.setBrightnessOption(selectedOption);
                              print(selectedOption);
                            });
                          },
                        ),
                      ],
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
}
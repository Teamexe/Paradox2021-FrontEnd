import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:paradox/providers/theme_provider.dart';
import 'package:paradox/screens/settings.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    BrightnessOption selectedOption = themeProvider.brightness;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: Text(
                'Dark Mode',
                style: TextStyle(
                    color: selectedOption == BrightnessOption.light
                        ? Colors.blue
                        : Colors.white,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              )),
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
    );
  }
}

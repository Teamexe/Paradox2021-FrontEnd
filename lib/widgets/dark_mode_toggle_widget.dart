import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:paradox/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (context, settingsProvider, child) => ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(settingsProvider.brightnessOption == BrightnessOption.dark ? Icons.wb_sunny : CupertinoIcons.moon_fill, size: 18, color: Colors.white),
              ),
              dense: true,
              title: settingsProvider.brightness == BrightnessOption.light
                  ? Text("Dark Theme",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ))
                  : Text("Light Theme",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      )),
              onTap: () {
                if (settingsProvider.brightness == BrightnessOption.light) {
                  settingsProvider.setBrightnessOption(BrightnessOption.dark);
                } else {
                  settingsProvider.setBrightnessOption(BrightnessOption.light);
                }
              },
              trailing: Switch(
                  activeColor: Colors.grey,
                  value: settingsProvider.brightness != BrightnessOption.light,
                  onChanged: (status) {
                    if (status == true) {
                      settingsProvider
                          .setBrightnessOption(BrightnessOption.dark);
                    } else {
                      settingsProvider
                          .setBrightnessOption(BrightnessOption.light);
                    }
                  }),
            ));
  }
}

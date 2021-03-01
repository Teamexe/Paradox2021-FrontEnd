import 'package:flutter/material.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:paradox/utilities/dark_theme_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  DarkThemePreferences darkThemePreferences = new DarkThemePreferences();
  BrightnessOption brightnessOption = BrightnessOption.light;

  void setBrightnessOption(BrightnessOption option) {
    brightnessOption = option;
    bool value = (brightnessOption == BrightnessOption.dark) ? true : false;
    darkThemePreferences.setDarkTheme(value);
    print('Theme mode: $brightnessOption');
    notifyListeners();
  }

  get brightness => brightnessOption;
}
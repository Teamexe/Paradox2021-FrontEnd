import 'package:flutter/material.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  BrightnessOption brightnessOption;
  static const THEME_MODE = "dark-mode";

  ThemeProvider() {
    brightnessOption = BrightnessOption.light;
    // retrieving current app theme
    getThemePreference();
  }

  // function to set theme
  void setBrightnessOption(BrightnessOption option) {
    brightnessOption = option;
    // updating shared preferences for theme
    setDarkTheme();
    print('Theme mode: $brightnessOption');
    notifyListeners();
  }

  // setting value in shared preferences cased on the selected theme
  setDarkTheme() async {
    bool value = brightnessOption == BrightnessOption.light ? false : true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(THEME_MODE, value);
  }

  // getting theme preference from shared preferences
  Future getThemePreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    brightnessOption = preferences.getBool(THEME_MODE) ?? false ? BrightnessOption.dark : BrightnessOption.light;
    notifyListeners();
  }

  get brightness => brightnessOption;
}
import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreferences {
  static const THEME_MODE = "dark-mode";

  setDarkTheme(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(THEME_MODE, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(THEME_MODE) ?? false;
  }

}
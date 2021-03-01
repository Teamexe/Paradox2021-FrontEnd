import 'package:flutter/material.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:paradox/providers/theme_provider.dart';
import 'package:provider/provider.dart';

Brightness brightness(BuildContext context) {
  BrightnessOption brightnessOption = Provider.of<ThemeProvider>(context, listen: true).brightness;
  if (brightnessOption == BrightnessOption.light)
    return Brightness.light;
  return Brightness.dark;
}
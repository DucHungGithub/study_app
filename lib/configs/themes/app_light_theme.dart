import 'package:flutter/material.dart';
import 'package:study_app_project/configs/themes/sub_theme_data_mixin.dart';

const Color primaryLightColorLight = Color(0xFF40e0d0);
const Color primaryColorLight = Color(0xFFff8c00);
const Color mainTextColorLight = Color.fromARGB(255, 40, 40, 40);
const Color cardColor = Color.fromARGB(255, 254, 254, 255);

class LightTheme with SubThemeData {
  buildLightTheme() {
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
        primaryColor: primaryColorLight,
        iconTheme: getIconTheme(),
        cardColor: cardColor,
        textTheme: getTextThemes().apply(
            bodyColor: mainTextColorLight, displayColor: mainTextColorLight));
  }
}

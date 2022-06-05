import 'package:flutter/material.dart';

const Color appBarColor = Color(0xffc6ced9);
const Color primaryColor = Color(0xffacb38c);
const Color borderColor = Color(0xffededed);

ThemeData themeLight = ThemeData(
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(primary: primaryColor, secondary: primaryColor),
);

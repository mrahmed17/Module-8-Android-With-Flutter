
import 'package:flutter/material.dart';
import 'package:hr_and_payroll_management/constants/Colors.dart';
import 'package:hr_and_payroll_management/constants/Sizes.dart';

class MyOutlinedButtonTheme{
  MyOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(),
        foregroundColor: tDarkColor,
        side: BorderSide(color: tSecondaryColor),
        padding: EdgeInsets.symmetric(vertical: tButtonHeight)
    ),
  );
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(),
        foregroundColor: tWhiteColor,
        side: BorderSide(color: tWhiteColor),
        padding: EdgeInsets.symmetric(vertical: tButtonHeight)
    ),
  );
}


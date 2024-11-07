

import 'package:flutter/material.dart';
import 'package:hr_and_payroll_management/constants/Colors.dart';
import 'package:hr_and_payroll_management/constants/Sizes.dart';

class MyElevatedButtonTheme{
  MyElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(),
        foregroundColor: tWhiteColor,
        backgroundColor: tSecondaryColor,
        side: BorderSide(color: tSecondaryColor),
        padding: EdgeInsets.symmetric(vertical: tButtonHeight)
    ),
  );
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(),
        foregroundColor: tSecondaryColor,
        backgroundColor: tWhiteColor,
        side: BorderSide(color: tSecondaryColor),
        padding: EdgeInsets.symmetric(vertical: tButtonHeight)
    ),
  );
}
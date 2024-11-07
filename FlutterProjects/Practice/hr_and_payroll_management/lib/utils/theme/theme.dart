import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_and_payroll_management/utils/theme/widget_theme/ElevatedButtonTheme.dart';
import 'package:hr_and_payroll_management/utils/theme/widget_theme/FloatingButtonTheme.dart';
import 'package:hr_and_payroll_management/utils/theme/widget_theme/OutlinedButtonTheme.dart';
import 'package:hr_and_payroll_management/utils/theme/widget_theme/TextFormFieldTheme.dart';
import 'package:hr_and_payroll_management/utils/theme/widget_theme/TextTheme.dart';

class MyAppTheme{
  MyAppTheme._();
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: MyTextTheme.lightTextTheme,
    outlinedButtonTheme: MyOutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: MyElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: MyTextFormFieldTheme.lightInputDecorationTheme,
    floatingActionButtonTheme: MyFloatingActionButtonTheme.FloatingActionButtonTheme,
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: MyTextTheme.darkTextTheme,
    outlinedButtonTheme: MyOutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: MyElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: MyTextFormFieldTheme.darkInputDecorationTheme,
    floatingActionButtonTheme: MyFloatingActionButtonTheme.FloatingActionButtonTheme,
  );
}
import 'package:flutter/material.dart';
import 'package:hr_and_payroll_management/utils/theme/theme.dart';
import 'package:get/get.dart';
import 'package:hr_and_payroll_management/features/dashboard/DashboardScreen.dart';
import 'package:hr_and_payroll_management/features/user/screens/UserListScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HR and Payroll Management System',
      theme: MyAppTheme.lightTheme,
      darkTheme: MyAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const DashboardScreen()), // Home dashboard
        GetPage(name: '/users', page: () => const UserListScreen()), // User list
        // GetPage(name: '/bonus', page: () => BonusScreen()), // Bonus management
        // GetPage(name: '/advance', page: () => AdvanceScreen()), // Advance payments
        // GetPage(name: '/leave', page: () => LeaveScreen()), // Leave management
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hr_and_pms/features/administration/dashboard/AdminDashboardScreen.dart';
import 'package:hr_and_pms/features/administration/dashboard/ManagerDashboardScreen.dart';
import 'package:hr_and_pms/features/attendance/screens/AttendanceScreen.dart';
import 'package:hr_and_pms/features/dashboard/DashboardScreen.dart';
import 'package:hr_and_pms/features/home/HomeScreen.dart';
import 'package:hr_and_pms/features/user/screens/UserListScreen.dart';
import 'package:hr_and_pms/features/user/screens/UserProfileScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HR and Payroll Management System',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      // home: AllDepartmentViewScreen(),
      home: HomeScreen(),
      // home: DashboardScreen(),
      // home: AttendanceScreen(),
      // home: ManagerDashboardScreen(),
      // home: AdminDashboardScreen(),
      // home: UserProfileScreen(userId: 7, role: "EMPLOYEE"),
      // home: UserListScreen(),
      // home: RegistrationScreen(),
      // home: LoginScreen(),
    );
  }
}
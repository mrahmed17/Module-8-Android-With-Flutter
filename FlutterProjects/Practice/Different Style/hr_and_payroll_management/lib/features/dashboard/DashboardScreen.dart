import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_and_payroll_management/features/user/screens/UserListScreen.dart';
// import 'package:hr_and_payroll_management/features/attendance/screens/AttendanceScreen.dart';
// import 'package:hr_and_payroll_management/features/payroll/screens/PayrollScreen.dart';
// import 'package:hr_and_payroll_management/features/leave/screens/LeaveScreen.dart';
// import 'package:hr_and_payroll_management/features/bonus/screens/BonusScreen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Widget _buildDashboardCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? backgroundColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: backgroundColor ?? Colors.white,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: iconColor ?? Colors.blue),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildDashboardCard(
              icon: Icons.people,
              title: "User Management",
              onTap: () => Get.to(() => const UserListScreen()),
              iconColor: Colors.deepPurple,
              backgroundColor: Colors.deepPurple.shade50,
            ),
            // _buildDashboardCard(
            //   icon: Icons.calendar_today,
            //   title: "Attendance",
            //   onTap: () => Get.to(() => const AttendanceScreen()),
            //   iconColor: Colors.blue,
            //   backgroundColor: Colors.blue.shade50,
            // ),
            // _buildDashboardCard(
            //   icon: Icons.attach_money,
            //   title: "Payroll",
            //   onTap: () => Get.to(() => const PayrollScreen()),
            //   iconColor: Colors.green,
            //   backgroundColor: Colors.green.shade50,
            // ),
            // _buildDashboardCard(
            //   icon: Icons.card_giftcard,
            //   title: "Bonuses",
            //   onTap: () => Get.to(() => const BonusScreen()),
            //   iconColor: Colors.orange,
            //   backgroundColor: Colors.orange.shade50,
            // ),
            // _buildDashboardCard(
            //   icon: Icons.vacation_rental,
            //   title: "Leave Management",
            //   onTap: () => Get.to(() => const LeaveScreen()),
            //   iconColor: Colors.red,
            //   backgroundColor: Colors.red.shade50,
            // ),
          ],
        ),
      ),
    );
  }
}

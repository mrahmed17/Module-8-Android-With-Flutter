import 'package:flutter/material.dart';
import 'package:hr_and_pms/features/attendance/screens/AttendanceScreen.dart';
// import 'package:hr_and_pms/features/salary/SalaryScreen.dart';
// import 'package:hr_and_pms/features/profile/ProfileScreen.dart';
// import 'package:hr_and_pms/features/feedback/FeedbackScreen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    // ProfileScreen(),
    AttendanceScreen(),
    // SalaryScreen(),
    // FeedbackScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Employee Dashboard',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: _selectedIndex == 0
          ? _buildDashboardGrid(context)
          : _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.teal, // Teal background color for navigation
        selectedItemColor: Colors.white, // White for selected item text and icon
        unselectedItemColor: Colors.teal.shade100, // Lighter teal for unselected items
        selectedFontSize: 14,
        unselectedFontSize: 14,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Salary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: 'Feedback',
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to respective feature screens
              // switch (index) {
              //   case 0:
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => AdvanceSalaryScreen()));
              //     break;
              //   case 1:
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => LeaveApplicationScreen()));
              //     break;
              //   case 2:
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => PayslipScreen()));
              //     break;
              //   default:
              //     break;
              // }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: _getGradientColor(index),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getIcon(index),
                      size: 40,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getLabel(index),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _getLabel(int index) {
    switch (index) {
      case 0:
        return 'Advance Salary';
      case 1:
        return 'Leave Application';
      case 2:
        return 'Payslip';
      default:
        return 'Feature';
    }
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.money;
      case 1:
        return Icons.work_off;
      case 2:
        return Icons.receipt_long;
      default:
        return Icons.help;
    }
  }

  List<Color> _getGradientColor(int index) {
    switch (index) {
      case 0:
        return [Colors.teal, Colors.teal];
      case 1:
        return [Colors.teal, Colors.teal];
      case 2:
        return [Colors.teal, Colors.teal];
      case 3:
        return [Colors.teal, Colors.teal];
      default:
        return [Colors.teal, Colors.teal];
    }
  }
}

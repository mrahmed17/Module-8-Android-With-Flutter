import 'package:flutter/material.dart';
import 'package:hr_and_pms/administration/model/User.dart';
import 'package:hr_and_pms/administration/screens/UserListScreen.dart';
import 'package:hr_and_pms/administration/screens/UserProfileScreen.dart';
import 'package:hr_and_pms/features/advanceSalary/Screens/AdvanceSalaryManagementScreen.dart';
import 'package:hr_and_pms/features/attendance/screens/AttendanceReportScreen.dart';
import 'package:hr_and_pms/features/bonus/Screens/CreateBonusScreen.dart';
import 'package:hr_and_pms/features/bonus/Screens/BonusManagementScreen.dart';
import 'package:hr_and_pms/features/leave/screens/LeaveManagementScreen.dart';
import 'package:hr_and_pms/features/paySlip/screens/CreatePaySlipScreen.dart';
import 'package:hr_and_pms/features/paySlip/screens/PaySlipScreen.dart';
import 'package:hr_and_pms/features/salary/screens/SalaryCalculationScreen.dart';
import 'package:hr_and_pms/features/salary/screens/SalaryCreateScreen.dart';
import 'package:hr_and_pms/administration/authScreen/LoginScreen.dart';
import 'package:hr_and_pms/administration/service/AuthService.dart';
import 'package:hr_and_pms/features/salary/screens/SalaryReportManagementScreen.dart';
import 'package:hr_and_pms/notification/NotificationScreen.dart';

class ManagerDashboardScreen extends StatefulWidget {
  const ManagerDashboardScreen({super.key});

  @override
  _ManagerDashboardScreenState createState() => _ManagerDashboardScreenState();
}

class _ManagerDashboardScreenState extends State<ManagerDashboardScreen> {
  User? _currentUser;
  int _selectedIndex = 0;

  final List<Widget> _screens = [];

  // Welcome message based on time
  String getWelcomeMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
    _checkAuthentication();
    _screens.addAll([
      ManagerDashboardScreenContent(parentContext: context),
      const UserProfileScreen(),
      const NotificationScreen(),
    ]);
  }

  Future<void> _fetchCurrentUser() async {
    try {
      final user = await AuthService().getUser();
      setState(() {
        _currentUser = user as User?;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user data: $e')),
      );
    }
  }

  Future<void> _checkAuthentication() async {
    if (!await AuthService().isLoggedIn()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  Future<void> _logout() async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout Confirmation'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );

    if (result == true) {
      await AuthService().logout();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      _logout();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manager Dashboard',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.doorbell_outlined),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
      ),
    );
  }
}

class ManagerDashboardScreenContent extends StatelessWidget {
  final BuildContext parentContext;

  const ManagerDashboardScreenContent({super.key, required this.parentContext});

  Widget _buildAnimatedFeatureCard({
    required IconData icon,
    required String label,
    required String subtitle,
    required Color color,
    required Widget screen,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          parentContext, // Use the parent context
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color.withOpacity(0.8),
              child: Icon(icon, size: 30, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: color),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {
        'icon': Icons.access_time,
        'label': 'Employee Management',
        'subtitle': 'View All Employee',
        'color': Colors.cyan,
        'screen': UserListScreen(),
      },{
        'icon': Icons.access_time,
        'label': 'Attendance Management',
        'subtitle': 'View attendance reports',
        'color': Colors.teal,
        'screen': AttendanceReportScreen(),
      },
      {
        'icon': Icons.manage_history_outlined,
        'label': 'Leave Management',
        'subtitle': 'Manage leave requests',
        'color': Colors.orange,
        'screen': LeaveManagementScreen(),
      },
      {
        'icon': Icons.money,
        'label': 'Advance Management',
        'subtitle': 'Manage advance salary',
        'color': Colors.blue,
        'screen': AdvanceSalaryManagementScreen(),
      },
      {
        'icon': Icons.currency_exchange,
        'label': 'Create Bonus',
        'subtitle': 'Add employee bonuses',
        'color': Colors.green,
        'screen': CreateBonusScreen(),
      },
      {
        'icon': Icons.currency_exchange_rounded,
        'label': 'Bonus Report',
        'subtitle': 'View or update bonuses',
        'color': Colors.purple,
        'screen': BonusManagementScreen(),
      },
      {
        'icon': Icons.money,
        'label': 'Create Salary',
        'subtitle': 'Generate salaries',
        'color': Colors.red,
        'screen': SalaryCreateScreen(),
      },
      {
        'icon': Icons.money,
        'label': 'Salary Report',
        'subtitle': 'Salaries History',
        'color': Colors.green,
        'screen': SalaryReportManagementScreen(),
      },
      {
        'icon': Icons.money,
        'label': 'Create Payslip',
        'subtitle': 'Generate Payslip',
        'color': Colors.teal,
        'screen': PaySlipScreen(),
      },
      {
        'icon': Icons.money,
        'label': 'Calculate Salary',
        'subtitle': 'Generate salaries',
        'color': Colors.indigo,
        'screen': SalaryCalculationScreen(),
      },
      {
        'icon': Icons.newspaper,
        'label': 'Create Salary',
        'subtitle': 'Generate salaries',
        'color': Colors.deepOrangeAccent,
        'screen': CreatePaySlipScreen(),
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: features.length,
        itemBuilder: (context, index) {
          final feature = features[index];
          return _buildAnimatedFeatureCard(
            icon: feature['icon'],
            label: feature['label'],
            subtitle: feature['subtitle'],
            color: feature['color'],
            screen: feature['screen'],
          );
        },
      ),
    );
  }
}

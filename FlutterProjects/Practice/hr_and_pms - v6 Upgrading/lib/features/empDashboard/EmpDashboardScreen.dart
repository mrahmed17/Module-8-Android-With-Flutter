import 'package:flutter/material.dart';
import 'package:hr_and_pms/administration/authScreen/LoginScreen.dart';
import 'package:hr_and_pms/administration/screens/UserProfileScreen.dart';
import 'package:hr_and_pms/administration/service/AuthService.dart';
import 'package:hr_and_pms/features/advanceSalary/Screens/ApplyAdvanceSalaryScreen.dart';
import 'package:hr_and_pms/features/attendance/screens/AttendanceScreen.dart';
import 'package:hr_and_pms/features/leave/screens/ApplyLeaveScreen.dart';
import 'package:intl/intl.dart';


class EmpDashboardScreen extends StatefulWidget {
  const EmpDashboardScreen({Key? key}) : super(key: key);

  @override
  _EmpDashboardScreenState createState() => _EmpDashboardScreenState();
}

class _EmpDashboardScreenState extends State<EmpDashboardScreen> {
  int _selectedIndex = 0;
  String? _currentUserName;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
    _checkAuthentication();
  }

  Future<void> _fetchCurrentUser() async {
    try {
      final user = await AuthService().getUser();
      setState(() {
        _currentUserName = user?.name ?? 'Employee';
      });
    } catch (e) {
      print('Error fetching user data: $e');
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
    final confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout Confirmation'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: const Text('Cancel', style: TextStyle(color: Colors.teal),),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: const Text('Logout', style: TextStyle(color: Colors.redAccent),),
          ),
        ],
      ),
    );

    if (confirm) {
      await AuthService().logout();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  void _onItemTapped(int index) {
    if (index == 4) {
      _logout();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

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

  Widget _buildClock() {
    return StreamBuilder<DateTime>(
      stream: Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            DateFormat('EEEE, MMMM d, yyyy • h:mm:ss a').format(snapshot.data!),
            style: const TextStyle(fontSize: 14, color: Colors.deepOrange, fontWeight: FontWeight.bold),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _buildDashboardGrid(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {'icon': Icons.access_time, 'label': 'Attendance', 'screen': AttendanceScreen()},
      {'icon': Icons.date_range, 'label': 'Apply Leave', 'screen': ApplyLeaveScreen()},
      {'icon': Icons.money, 'label': 'Advance Salary', 'screen': ApplyAdvanceSalaryScreen()},
      {'icon': Icons.person, 'label': 'Profile', 'screen': UserProfileScreen()},
      {'icon': Icons.history, 'label': 'Salary History', 'screen': null},
      {'icon': Icons.file_present, 'label': 'Payslip', 'screen': null},
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: features.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 icons per row
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemBuilder: (context, index) {
          final feature = features[index];
          return GestureDetector(
            onTap: () {
              if (feature['screen'] != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => feature['screen']),
                );
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.teal, width: 1),
                  ),
                  child: Icon(
                    feature['icon'],
                    size: 40,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  feature['label'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Employee Dashboard',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${getWelcomeMessage()}, ${_currentUserName ?? 'Employee'}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.teal),
                  ),
                  _buildClock(),
                ],
              ),
            ),
            _buildDashboardGrid(context),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.work_off), label: 'Leave'),
          const BottomNavigationBarItem(icon: Icon(Icons.feedback), label: 'Feedback'),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          const BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Logout'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

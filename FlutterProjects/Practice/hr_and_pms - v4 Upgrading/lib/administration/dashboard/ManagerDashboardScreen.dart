import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hr_and_pms/administration/screens/UserListScreen.dart';
import 'package:hr_and_pms/administration/screens/UserProfileScreen.dart';
import 'package:intl/intl.dart'; // For formatting date and time
import 'package:hr_and_pms/administration/authScreen/LoginScreen.dart';
import 'package:hr_and_pms/administration/model/User.dart';
import 'package:hr_and_pms/administration/service/AuthService.dart';
import 'package:hr_and_pms/features/attendance/screens/AttendanceReportScreen.dart';
import 'package:hr_and_pms/features/leave/screens/LeaveManagementScreen.dart';

class ManagerDashboardScreen extends StatefulWidget {
  const ManagerDashboardScreen({super.key});

  @override
  _ManagerDashboardScreenState createState() => _ManagerDashboardScreenState();
}

class _ManagerDashboardScreenState extends State<ManagerDashboardScreen> {
  int _selectedIndex = 0;
  User? _currentUser;

  // Welcome message and current time
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

  String getCurrentDateTime() {
    return DateFormat('EEEE, MMMM d, yyyy • h:mm a').format(DateTime.now());
  }

  final List<Widget> _screens = [
    AttendanceReportScreen(),
    LeaveManagementScreen(),
    LoginScreen(),
    UserListScreen(),
    Container(), // Placeholder for Feedback
    Container(), // Placeholder for Logout
  ];

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
    // _startClock();
  }

  /// Fetch the currently logged-in user's details
  Future<void> _fetchCurrentUser() async {
    try {
      final user = await AuthService().getUser();
      if (user != null) {
        setState(() {
          _currentUser = user;
        });
      } else {
        // Handle no user found
        print('No user data available');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }


  /// Start the real-time clock
  // void _startClock() {
  //   Timer.periodic(const Duration(seconds: 1), (timer) {
  //     final now = DateTime.now();
  //     final formattedTime = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
  //     final formattedDate = "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";
  //     setState(() {
  //       _currentTime = "$formattedDate | $formattedTime";
  //     });
  //   });
  // }

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
          'Manager Dashboard',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: _selectedIndex == 0
          ? _buildDashboardGrid(context)
          : _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.indigo.shade100,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: 'Feedback',
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.logout),
              label: 'Logout',
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${getWelcomeMessage()}, ${_currentUser!.name}!',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
              Text(
                getCurrentDateTime(),
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              // Text(
              //   _currentTime,
              //   style: const TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w600,
              //     color: Colors.grey,
              //   ),
              // ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
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
                    switch (index) {
                      case 0:
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceReportScreen()));
                        break;
                      case 1:
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LeaveManagementScreen()));
                        break;
                        case 2:
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserListScreen()));
                        break;
                        case 2:
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileScreen()));
                        break;
                      default:
                        break;
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
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
          ),
        ),
      ],
    );
  }

  String _getLabel(int index) {
    switch (index) {
      case 0:
        return 'Attendance Report';
      case 1:
        return 'Leave Report';
        case 2:
        return 'Employee List';
      default:
        return 'Coming Soon';
    }
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.access_time;
      case 1:
        return Icons.work_off;
      case 2:
        return Icons.people;
      default:
        return Icons.help;
    }
  }

  List<Color> _getGradientColor(int index) {
    switch (index) {
      case 0:
        return [Colors.blueAccent, Colors.lightBlueAccent];
      case 1:
        return [Colors.orangeAccent, Colors.deepOrangeAccent];
      case 2:
        return [Colors.green, Colors.greenAccent];
      default:
        return [Colors.grey, Colors.black12];
    }
  }
}

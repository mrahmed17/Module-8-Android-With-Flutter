import 'package:flutter/material.dart';
import 'package:hr_and_pms/administration/authScreen/LoginScreen.dart';
import 'package:hr_and_pms/features/attendance/screens/AttendanceLookupScreen.dart'; // Import AttendanceLookupScreen
import 'package:hr_and_pms/features/attendance/screens/AttendanceOverviewScreen.dart'; // Import AttendanceOverviewScreen
import 'package:hr_and_pms/features/attendance/screens/AttendanceAnalyticsScreen.dart';
import 'package:hr_and_pms/features/user/model/User.dart';
import 'package:hr_and_pms/features/user/service/UserService.dart'; // Import AttendanceAnalyticsScreen
import 'package:hr_and_pms/features/user/screens/UserProfileScreen.dart'; // Import UserProfileScreen

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;
  List<User> _users = [];
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      // Assuming UserService has a method to fetch users
      UserService userService = UserService();
      List<User> users = await userService.getAllUsers();  // Fetch all users
      setState(() {
        _users = users;
        // Assuming the first user is the current admin for demo purposes
        _currentUser = users.isNotEmpty ? users[0] : null;
      });
    } catch (e) {
      // Handle error, maybe show a message to the admin
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching users: $e')),
      );
    }
  }

  void _onBottomNavigationItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        actions: [
          PopupMenuButton<int>(
            onSelected: (int index) {
              _onDropdownItemSelected(index);
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<int>(value: 0, child: Text('Attendance Lookup')),
              const PopupMenuItem<int>(value: 1, child: Text('Attendance Overview')),
              const PopupMenuItem<int>(value: 2, child: Text('Attendance Analytics')),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Section
            _currentUser != null
                ? GestureDetector(
              onTap: () {
                // Navigate to User Profile Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfileScreen(user: _currentUser!)),
                );
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(_currentUser!.profilePhoto ?? 'https://via.placeholder.com/150'), // Use a placeholder or actual URL
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _currentUser!.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        _currentUser!.role.name, // Assuming `role` is a `Role` object
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
                : const SizedBox(),

            // Main Dashboard Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      switch (index) {
                        case 0:
                          print('View Employees Clicked');
                          break;
                        case 1:
                          print('View Departments Clicked');
                          break;
                        case 2:
                          print('Add Department Clicked');
                          break;
                        case 3:
                          print('Settings Clicked');
                          break;
                        case 4:
                          print('Logout Clicked');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                          break;
                        default:
                          break;
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.teal, // Single color theme
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.shade700.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(3, 3),
                          ),
                        ],
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
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavigationItemTapped,
        backgroundColor: Colors.teal,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.teal.shade100,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  void _onDropdownItemSelected(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AttendanceLookupScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AttendanceOverviewScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AttendanceAnalyticsScreen()),
        );
        break;
      default:
        break;
    }
  }

  String _getLabel(int index) {
    switch (index) {
      case 0:
        return 'View Employees';
      case 1:
        return 'View Departments';
      case 2:
        return 'Add Department';
      case 3:
        return 'Settings';
      case 4:
        return 'Logout';
      default:
        return '';
    }
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.people;
      case 1:
        return Icons.business;
      case 2:
        return Icons.add;
      case 3:
        return Icons.settings;
      case 4:
        return Icons.exit_to_app;
      default:
        return Icons.help;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:hr_and_pms/features/administration/authentication/LoginScreen.dart';

class ManagerDashboardScreen extends StatelessWidget {
  const ManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manager Dashboard'),
        automaticallyImplyLeading: false, // Hides the back button
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 columns in each row
            crossAxisSpacing: 16, // Horizontal space between columns
            mainAxisSpacing: 16, // Vertical space between rows
            childAspectRatio: 1, // Adjust the aspect ratio for square-shaped grid items
          ),
          itemCount: 6, // Total number of items
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Implement navigation logic for each button
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
                  gradient: LinearGradient(
                    colors: [
                      _getGradientColor(index)[0],
                      _getGradientColor(index)[1],
                    ],
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
                      SizedBox(height: 8),
                      Text(
                        _getLabel(index),
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
    );
  }

  // Get the label for each item based on index
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

  // Get the icon for each item based on index
  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.people;
      case 1:
        return Icons.house;
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

  // Get the gradient colors for each grid item based on index
  List<Color> _getGradientColor(int index) {
    switch (index) {
      case 0:
        return [Colors.blueAccent, Colors.lightBlue];
      case 1:
        return [Colors.orangeAccent, Colors.orange];
      case 2:
        return [Colors.greenAccent, Colors.green];
      case 3:
        return [Colors.purpleAccent, Colors.purple];
      case 4:
        return [Colors.redAccent, Colors.red];
      default:
        return [Colors.grey, Colors.grey];
    }
  }
}

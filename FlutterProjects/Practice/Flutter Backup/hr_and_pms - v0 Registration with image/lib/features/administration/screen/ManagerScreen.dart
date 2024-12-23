import 'package:flutter/material.dart';
import 'package:hr_and_pms/features/administration/screen/LoginScreen.dart';


class ManagerScreen extends StatelessWidget {
  const ManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manager Dashboard'),
        automaticallyImplyLeading: false, //for hides the back button
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome, Dear Manager!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.people),
              label: Text('View All Employees'),
              onPressed: () {
                //navigate to users page or call an api to fetch users
                print('View Employees Clicked');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.house),
              label: Text('View All Departments'),
              onPressed: () {
                // navigate to manage departments page or call an api to manage departments
                print('View Departments Clicked');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text('Add Department'),
              onPressed: () {
                // Implement logout functionality or navigate back to login
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => AddDepartmentScreen()),
                // );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.settings),
              label: Text("Settings"),
              onPressed: () {
                //Navigate to settings page
                print("Settings clicked");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // implement logout functionality or navigate back to login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                ); // Example logout: navigate back to login
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

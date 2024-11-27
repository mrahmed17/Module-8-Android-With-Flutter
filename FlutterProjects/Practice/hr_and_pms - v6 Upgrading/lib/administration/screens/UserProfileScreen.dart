import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Map<String, dynamic>? user;
  String? role;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    String? userRole = prefs.getString('userRole');

    setState(() {
      user = userJson != null ? jsonDecode(userJson) : null;
      role = userRole;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
        backgroundColor: Colors.teal,
      ),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Profile Picture
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: (user!['profilePhoto'] != null && user!['profilePhoto'].isNotEmpty)
                    ? NetworkImage("http://localhost:8080/uploadDirectory/images/profilePhotos/${user!['profilePhoto']}")
                    : const AssetImage('assets/images/profile_demo/profile.png') as ImageProvider,
                onBackgroundImageError: (exception, stackTrace) {
                  print("Failed to load image: $exception");
                },
              ),
            ),
            SizedBox(height: 16),
            // User Name
            Center(
              child: Text(
                user!['name'] ?? 'Unknown User',
                style: TextStyle(

                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            // Role Badge
            Center(
              child: Chip(
                label: Text(
                  role?.toUpperCase() ?? 'UNKNOWN ROLE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.teal,
              ),
            ),
            SizedBox(height: 16),
            Divider(),
            // Profile Details
            ProfileDetailItem(
              icon: Icons.email,
              title: "Email",
              value: user!['email'] ?? 'N/A',
            ),
            ProfileDetailItem(
              icon: Icons.phone,
              title: "Phone",
              value: user!['cell'] ?? 'N/A',
            ),
            ProfileDetailItem(
              icon: Icons.calendar_today,
              title: "Joined Date",
              value: user!['joinedDate'] ?? 'N/A',
            ),
            ProfileDetailItem(
              icon: Icons.location_city,
              title: "Department",
              value: user!['department'] ?? 'N/A',
            ),
            SizedBox(height: 16),
            // Role-Specific Details
            if (role == 'ADMIN') ..._adminSpecificDetails(),
            if (role == 'MANAGER') ..._managerSpecificDetails(),
            if (role == 'EMPLOYEE') ..._employeeSpecificDetails(),
          ],
        ),
      ),
    );
  }

  // Admin-specific details
  List<Widget> _adminSpecificDetails() {
    return [
      Divider(),
      Text(
        "Admin Privileges",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      ProfileDetailItem(
        icon: Icons.admin_panel_settings,
        title: "Access Level",
        value: "Full System Access",
      ),
    ];
  }

  // Manager-specific details
  List<Widget> _managerSpecificDetails() {
    return [
      Divider(),
      Text(
        "Manager Responsibilities",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      ProfileDetailItem(
        icon: Icons.group,
        title: "Team Size",
        value: user!['teamSize']?.toString() ?? 'N/A',
      ),
    ];
  }

  // Employee-specific details
  List<Widget> _employeeSpecificDetails() {
    return [
      Divider(),
      Text(
        "Employee Information",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      ProfileDetailItem(
        icon: Icons.work,
        title: "Position",
        value: user!['position'] ?? 'N/A',
      ),
      ProfileDetailItem(
        icon: Icons.attach_money,
        title: "Salary",
        value: user!['basicSalary']?.toString() ?? 'N/A',
      ),
    ];
  }
}

class ProfileDetailItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ProfileDetailItem({super.key, 
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(title),
      subtitle: Text(value),
    );
  }
}

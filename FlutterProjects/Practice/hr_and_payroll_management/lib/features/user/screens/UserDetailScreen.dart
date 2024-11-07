import 'package:flutter/material.dart';
import 'package:hr_and_payroll_management/features/user/models/User.dart';
import 'package:hr_and_payroll_management/features/user/services/UserService.dart';
import 'UserFormScreen.dart';

class UserDetailScreen extends StatefulWidget {
  final int userId;

  UserDetailScreen({required this.userId});

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  User? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    user = await UserService().findUserById(widget.userId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserFormScreen(user: user)),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : user != null
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Full Name: ${user!.fullName}"),
            Text("Email: ${user!.email}"),
            Text("Role: ${user!.role}"),
            // Add more fields as needed
          ],
        ),
      )
          : Center(child: Text("User not found")),
    );
  }
}

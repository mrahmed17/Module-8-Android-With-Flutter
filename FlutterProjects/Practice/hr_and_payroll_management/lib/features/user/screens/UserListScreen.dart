import 'package:flutter/material.dart';
import 'package:hr_and_payroll_management/features/user/models/User.dart';
import 'package:hr_and_payroll_management/features/user/screens/UserDetailScreen.dart';
import 'package:hr_and_payroll_management/features/user/screens/UserFormScreen.dart';
import 'package:hr_and_payroll_management/features/user/services/UserService.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> users = [];
  int currentPage = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    setState(() {
      isLoading = true;
    });

    List<User> fetchedUsers =
        await UserService().getAllUsers(page: currentPage, size: 10);
    setState(() {
      users.addAll(fetchedUsers);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User List"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserFormScreen()),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user.fullName),
                  subtitle: Text(user.email),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailScreen(userId: user.id),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

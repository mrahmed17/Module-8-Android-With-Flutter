import 'package:flutter/material.dart';
import 'package:hr_and_pms/features/user/service/UserService.dart';
import 'package:hr_and_pms/features/user/model/User.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileScreen extends StatefulWidget {
  final User user;
  final int userId;
  final String role;

  const UserProfileScreen({super.key, required this.userId, required this.role, required this.user});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final UserService _userService = UserService();
  User? _user;
  List<User> _users = [];
  bool _loading = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    setState(() {
      _loading = true;
    });
    try {
      _users = await _userService.getAllUsers();  // Fetch all users
    } catch (e) {
      // Handle error (show error message)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _updateUserProfile(User updatedUser, XFile? profilePhoto) async {
    try {
      String result = await _userService.updateUser(updatedUser.id, updatedUser, profilePhoto);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
      // Optionally refresh the user details after update
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating user: $e')));
    }
  }


  void _deleteUser() async {
    final confirmation = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmation == true) {
      await _userService.deleteUser(widget.userId);
      Navigator.pop(context);
    }
  }

  Future<void> _deleteUser(int userId) async {
    try {
      await _userService.deleteUser(userId); // Delete user by ID
      setState(() {
        _users.removeWhere((user) => user.id == userId); // Remove from local list
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User deleted successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete user: $e')));
    }
  }

  void _navigateToUserProfile(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfileScreen(userId: user.id, role: user.role, user: null,),
      ),
    );
  }
  
  Widget _buildUserImage(String? profilePhoto) {
    final imageUrl = profilePhoto != null
        ? "http://localhost:8080/uploadDir/images/$profilePhoto"
        : null;
    return imageUrl != null
        ? Image.network(
      imageUrl,
      width: 100,
      height: 100,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.error);
      },
      loadingBuilder: (context, child, progress) {
        return progress == null ? child : const CircularProgressIndicator();
      },
    )
        : const Icon(Icons.person, size: 100);
  }

  Widget _buildPersonalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text('Name: ${_user!.name}', style: const TextStyle(fontSize: 18)),
        Text('Email: ${_user!.email}'),
        Text('Address: ${_user!.address}'),
        Text('Contact: ${_user!.contact}'),
        Text('Gender: ${_user!.gender}'),
        Text('Date of Birth: ${_user!.dateOfBirth.toLocal().toString().split(' ')[0]}'),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildEmploymentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text('National ID: ${_user!.nationalId}'),
        Text('Joined Date: ${_user!.joinedDate.toLocal().toString().split(' ')[0]}'),
        // Text('Department: ${_user!.department}'),
        if (widget.role == 'Manager' || widget.role == 'Admin')
          // Text('Supervisor: ${_user!.supervisor ?? "N/A"}'),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Edit Profile Button (for Admins and Managers)
        if (widget.role != 'Employee')
          ElevatedButton(
            onPressed: () {
              // Navigate to Edit Profile Screen
              print('Edit Profile Clicked');
            },
            child: const Text('Edit Profile'),
          ),
        // Delete Button (for Admins only)
        if (widget.role == 'Admin')
          ElevatedButton(
            onPressed: _deleteUser,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete User'),
          ),
      ],
    );
  }

  Widget _buildEmployeeSelfServiceOptions() {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.history),
          title: const Text('Salary History'),
          onTap: () {
            print('Salary History Clicked');
          },
        ),
        ListTile(
          leading: const Icon(Icons.description),
          title: const Text('Payslip'),
          onTap: () {
            print('Payslip Clicked');
          },
        ),
        ListTile(
          leading: const Icon(Icons.feedback),
          title: const Text('Feedback'),
          onTap: () {
            print('Feedback Clicked');
          },
        ),
        ListTile(
          leading: const Icon(Icons.date_range),
          title: const Text('Leave History'),
          onTap: () {
            print('Leave History Clicked');
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name} - Profile'),
        subtitle: Text(user.role),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _navigateToUserProfile(user),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteUser(user.id),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage("http://localhost:8080/uploadDir/images/${user.profilePhoto}"),
        ),
        onBackgroundImageError: (_, __) => const Icon(Icons.person),
        const SizedBox(height: 16),
        Text(
          user.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          user.role.name,  // Assuming role is a String or has a `name` property
          style: const TextStyle(fontSize: 16, color: Colors.teal),
        ),
            ),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _user == null
                ? const Center(child: Text('User not found'))
                : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: _buildUserImage(_user!.profilePhoto)),
                    const SizedBox(height: 20),
                    Text(_user!.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('Role: ${widget.role}', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                    const Divider(),
                    _buildPersonalInfo(),
                    _buildEmploymentDetails(),
                    const Divider(),
                    if (widget.role == 'Employee') _buildEmployeeSelfServiceOptions(),
                    _buildActions(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

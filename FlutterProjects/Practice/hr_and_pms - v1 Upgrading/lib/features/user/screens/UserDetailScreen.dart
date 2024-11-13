import 'package:flutter/material.dart';
import 'package:hr_and_pms/features/user/UserService.dart';
import 'package:hr_and_pms/features/user/model/User.dart';


class UserDetailScreen extends StatefulWidget {
  final int userId;

  const UserDetailScreen({super.key, required this.userId});

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final UserService _userService = UserService();
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    try {
      User? user = await _userService.findUserById(widget.userId);
      setState(() {
        _user = user;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user details: $e')),
      );
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

  Widget _buildUserImage(String? profilePhoto) {
    final imageUrl = profilePhoto != null
        ? "http://localhost:8080/uploadDirectory/profilePhotos/raju_0f9a26bb-e6fa-4ab3-8e16-9a4079e60a83.jpg"
        : null;
    print(imageUrl);
    return imageUrl != null
        ? Image.network(
      imageUrl,
      width: 100,
      height: 100,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        print('Image loading error: $error');
        print('Stack trace: $stackTrace');
        return const Icon(Icons.error);
      },
      loadingBuilder: (context, child, progress) {
        return progress == null ? child : const CircularProgressIndicator();
      },
    )
        : const Icon(Icons.person, size: 100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Details')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _user == null
          ? const Center(child: Text('User not found'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: _buildUserImage(_user!.profilePhoto)),
            const SizedBox(height: 20),
            Text('Name: ${_user!.fullName}',
                style: const TextStyle(fontSize: 18)),
            Text('Email: ${_user!.email}'),
            Text('Address: ${_user!.address}'),
            Text('Contact: ${_user!.contact}'),
            Text('Gender: ${_user!.gender}'),
            Text(
                'Date of Birth: ${_user!.dateOfBirth.toLocal().toString().split(' ')[0]}'),
            Text('National ID: ${_user!.nationalId}'),
            Text(
                'Joined Date: ${_user!.joinedDate.toLocal().toString().split(' ')[0]}'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) =>
                //             UserFormScreen(user: _user),
                //       ),
                //     );
                //   },
                //   child: const Text('Edit User'),
                // ),
                ElevatedButton(
                  onPressed: _deleteUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Delete User'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

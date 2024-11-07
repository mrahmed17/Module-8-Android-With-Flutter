import 'package:flutter/material.dart';
import 'package:hr_and_payroll_management/features/user/models/Role.dart';
import 'package:hr_and_payroll_management/features/user/models/User.dart';
import 'package:hr_and_payroll_management/features/user/services/UserService.dart';

class UserFormScreen extends StatefulWidget {
  final User? user;

  const UserFormScreen({super.key, this.user});

  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final UserService _userService = UserService();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _contactController;
  String _gender = 'Male';
  Role _role = Role.EMPLOYEE;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.user?.fullName ?? '');
    _emailController = TextEditingController(text: widget.user?.email ?? '');
    _addressController = TextEditingController(text: widget.user?.address ?? '');
    _contactController = TextEditingController(text: widget.user?.contact ?? '');
    _gender = widget.user?.gender ?? 'Male';
    _role = widget.user?.role ?? Role.EMPLOYEE;
  }

  Future<void> _saveUser() async {
    if (_formKey.currentState!.validate()) {
      User user = User(
        id: widget.user?.id ?? 0,
        fullName: _fullNameController.text,
        email: _emailController.text,
        password: 'password', // Replace as needed
        address: _addressController.text,
        gender: _gender,
        dateOfBirth: DateTime.now(),
        nationalId: '12345',
        contact: _contactController.text,
        basicSalary: 0.0,
        joinedDate: DateTime.now(),
        profilePhoto: '',
        role: _role,
        attendances: [],
      );

      if (widget.user == null) {
        await _userService.createUser(user, null);
      } else {
        await _userService.updateUser(user.id, user, null);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.user == null ? 'Create User' : 'Edit User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Please enter an email' : null,
              ),
              DropdownButtonFormField<String>(
                value: _gender,
                items: ['Male', 'Female', 'Other']
                    .map((label) => DropdownMenuItem(
                  value: label,
                  child: Text(label),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _gender = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Gender'),
              ),
              DropdownButtonFormField<Role>(
                value: _role,
                items: Role.values
                    .map((role) => DropdownMenuItem(
                  value: role,
                  child: Text(role.toString().split('.').last),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _role = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Role'),
              ),
              ElevatedButton(
                onPressed: _saveUser,
                child: Text(widget.user == null ? 'Create' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

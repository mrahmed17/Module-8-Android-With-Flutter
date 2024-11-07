import 'package:flutter/material.dart';
import 'package:hr_and_payroll_management/features/user/models/Role.dart';
import 'package:hr_and_payroll_management/features/user/models/User.dart';
import 'package:hr_and_payroll_management/features/user/services/UserService.dart';


class UserFormScreen extends StatefulWidget {
  final User? user;

  UserFormScreen({this.user});

  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController fullNameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController(text: widget.user?.fullName ?? '');
    emailController = TextEditingController(text: widget.user?.email ?? '');
  }

  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      User newUser = User(
        id: widget.user?.id ?? 0,
        fullName: fullNameController.text,
        email: emailController.text,
        password: widget.user?.password ?? "default_password",
        address: widget.user?.address ?? "default_address",
        gender: widget.user?.gender ?? "Other",
        dateOfBirth: widget.user?.dateOfBirth ?? DateTime.now(),
        nationalId: widget.user?.nationalId ?? "0000000000",
        contact: widget.user?.contact ?? "1234567890",
        basicSalary: widget.user?.basicSalary ?? 0.0,
        joinedDate: widget.user?.joinedDate ?? DateTime.now(),
        profilePhoto: widget.user?.profilePhoto ?? "default.jpg",
        role: widget.user?.role ?? Role.USER,
        attendances: widget.user?.attendances ?? [],
      );

      if (widget.user == null) {
        await UserService().createUser(newUser);
      } else {
        await UserService().updateUser(newUser.id, newUser);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? 'Create User' : 'Edit User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter full name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: submitForm,
                child: Text(widget.user == null ? 'Create User' : 'Update User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

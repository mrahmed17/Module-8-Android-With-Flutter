import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For picking the image
import 'package:hr_and_payroll_management/features/user/model/Role.dart';
import 'package:hr_and_payroll_management/features/user/model/User.dart';
import 'package:hr_and_payroll_management/features/user/UserService.dart';
import 'package:intl/intl.dart' show DateFormat;

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
  late TextEditingController _passwordController;
  late TextEditingController _nationalIdController;
  late TextEditingController _basicSalaryController;
  late TextEditingController _dateOfBirthController;

  String _gender = 'Male';
  Role _role = Role.EMPLOYEE;
  XFile? _profilePhoto;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.user?.fullName ?? '');
    _emailController = TextEditingController(text: widget.user?.email ?? '');
    _addressController = TextEditingController(text: widget.user?.address ?? '');
    _contactController = TextEditingController(text: widget.user?.contact ?? '');
    _passwordController = TextEditingController(text: widget.user?.password ?? '');
    _nationalIdController = TextEditingController(text: widget.user?.nationalId ?? '');
    _basicSalaryController = TextEditingController(text: widget.user?.basicSalary.toString() ?? '0');
    _dateOfBirthController = TextEditingController(
      text: widget.user?.dateOfBirth != null
          ? DateFormat('dd/MM/yyyy').format(widget.user!.dateOfBirth)
          : '',
    );
    _gender = widget.user?.gender ?? 'Male';
    _role = widget.user?.role ?? Role.EMPLOYEE;
  }

  Future<void> _saveUser() async {
    if (_formKey.currentState!.validate()) {
      User user = User(
        id: widget.user?.id ?? 0,
        fullName: _fullNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        address: _addressController.text,
        gender: _gender,
        dateOfBirth: DateFormat('dd/MM/yyyy').parse(_dateOfBirthController.text),
        nationalId: _nationalIdController.text,
        contact: _contactController.text,
        basicSalary: double.tryParse(_basicSalaryController.text) ?? 0.0,
        joinedDate: DateTime.now(),
        profilePhoto: '',
        role: _role,
        attendances: [],
      );

      await _userService.createUser(user, _profilePhoto);
      Navigator.pop(context);
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profilePhoto = pickedFile;
      });
    }
  }

  Future<void> _selectDateOfBirth(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    if (_dateOfBirthController.text.isNotEmpty) {
      initialDate = DateFormat('dd/MM/yyyy').parse(_dateOfBirthController.text);
    }

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != initialDate) {
      setState(() {
        _dateOfBirthController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  String _passwordStrength(String password) {
    if (password.length < 6) return 'Weak';
    if (password.length < 10) return 'Medium';
    return 'Strong';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.user == null ? 'Create User' : 'Edit User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              ),
              SizedBox(height: 16,),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Please enter an email' : null,
              ),
              SizedBox(height: 16,),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
                onChanged: (value) => setState(() {}),
              ),
              Text('Password Strength: ${_passwordStrength(_passwordController.text)}'),
              SizedBox(height: 16,),
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(labelText: 'Contact'),
                validator: (value) => value!.isEmpty ? 'Please enter a contact number' : null,
              ),
              SizedBox(height: 16,),
              TextFormField(
                controller: _nationalIdController,
                decoration: const InputDecoration(labelText: 'National ID'),
                validator: (value) => value!.isEmpty ? 'Please enter National ID' : null,
              ),
              SizedBox(height: 16,),
              TextFormField(
                controller: _basicSalaryController,
                decoration: const InputDecoration(labelText: 'Basic Salary'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter basic salary' : null,
              ),
              SizedBox(height: 16,),
              GestureDetector(
                onTap: () => _selectDateOfBirth(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dateOfBirthController,
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    validator: (value) => value!.isEmpty ? 'Please enter date of birth' : null,
                  ),
                ),
              ),
              SizedBox(height: 16,),
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
              SizedBox(height: 16,),
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
              SizedBox(height: 16,),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.grey[200],
                  child: Center(
                    child: _profilePhoto == null
                        ? const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.camera_alt, color: Colors.grey),
                        Text("Choose a profile photo"),
                        SizedBox(height: 16,),
                        Text('Select Profile Photo'),
                      ],
                    )
                        : CircleAvatar(
                      backgroundImage: kIsWeb
                          ? NetworkImage(_profilePhoto!.path)
                          : FileImage(File(_profilePhoto!.path)) as ImageProvider,
                      radius: 50,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16,),
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

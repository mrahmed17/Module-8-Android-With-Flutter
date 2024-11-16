import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Add this package for image picking
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
  late TextEditingController _passwordController;
  late TextEditingController _nationalIdController;
  late TextEditingController _basicSalaryController;
  late TextEditingController _dateOfBirthController;

  String _gender = 'Male';
  Role _role = Role.EMPLOYEE;
  File? _profilePhoto;

  final ImagePicker _picker = ImagePicker();  // For picking the image

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
    _dateOfBirthController = TextEditingController(text: widget.user?.dateOfBirth.toIso8601String() ?? '');
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
        dateOfBirth: DateTime.parse(_dateOfBirthController.text),
        nationalId: _nationalIdController.text,
        contact: _contactController.text,
        basicSalary: double.tryParse(_basicSalaryController.text) ?? 0.0,
        joinedDate: DateTime.now(),
        profilePhoto: '', // Will handle photo upload via multipart
        role: _role,
        attendances: [],
      );

      // Picked photo logic
      if (_profilePhoto != null) {
        await _userService.createUser(user, _profilePhoto!.path); // Upload the selected image
      } else {
        await _userService.createUser(user, null);  // If no photo selected
      }

      Navigator.pop(context);
    }
  }

  // Function to pick image from gallery or camera
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profilePhoto = File(pickedFile.path);
      });
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
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
                obscureText: true,
              ),
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(labelText: 'Contact'),
                validator: (value) => value!.isEmpty ? 'Please enter a contact number' : null,
              ),
              TextFormField(
                controller: _nationalIdController,
                decoration: const InputDecoration(labelText: 'National ID'),
                validator: (value) => value!.isEmpty ? 'Please enter National ID' : null,
              ),
              TextFormField(
                controller: _basicSalaryController,
                decoration: const InputDecoration(labelText: 'Basic Salary'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter basic salary' : null,
              ),
              TextFormField(
                controller: _dateOfBirthController,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                keyboardType: TextInputType.datetime,
                validator: (value) => value!.isEmpty ? 'Please enter date of birth' : null,
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
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.grey[200],
                  child: _profilePhoto == null
                      ? const Text('Select Profile Photo')
                      : Image.file(_profilePhoto!, width: 100, height: 100),
                ),
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



// import 'package:flutter/material.dart';
// import 'package:hr_and_payroll_management/features/user/models/Role.dart';
// import 'package:hr_and_payroll_management/features/user/models/User.dart';
// import 'package:hr_and_payroll_management/features/user/services/UserService.dart';
//
// class UserFormScreen extends StatefulWidget {
//   final User? user;
//
//   const UserFormScreen({super.key, this.user});
//
//   @override
//   _UserFormScreenState createState() => _UserFormScreenState();
// }
//
// class _UserFormScreenState extends State<UserFormScreen> {
//   final UserService _userService = UserService();
//   final _formKey = GlobalKey<FormState>();
//
//   late TextEditingController _fullNameController;
//   late TextEditingController _emailController;
//   late TextEditingController _addressController;
//   late TextEditingController _contactController;
//   String _gender = 'Male';
//   Role _role = Role.EMPLOYEE;
//
//   @override
//   void initState() {
//     super.initState();
//     _fullNameController = TextEditingController(text: widget.user?.fullName ?? '');
//     _emailController = TextEditingController(text: widget.user?.email ?? '');
//     _addressController = TextEditingController(text: widget.user?.address ?? '');
//     _contactController = TextEditingController(text: widget.user?.contact ?? '');
//     _gender = widget.user?.gender ?? 'Male';
//     _role = widget.user?.role ?? Role.EMPLOYEE;
//   }
//
//   Future<void> _saveUser() async {
//     if (_formKey.currentState!.validate()) {
//       User user = User(
//         id: widget.user?.id ?? 0,
//         fullName: _fullNameController.text,
//         email: _emailController.text,
//         password: 'password', // Replace as needed
//         address: _addressController.text,
//         gender: _gender,
//         dateOfBirth: DateTime.now(),
//         nationalId: '12345',
//         contact: _contactController.text,
//         basicSalary: 0.0,
//         joinedDate: DateTime.now(),
//         profilePhoto: '',
//         role: _role,
//         attendances: [],
//       );
//
//       if (widget.user == null) {
//         await _userService.createUser(user, null);
//       } else {
//         await _userService.updateUser(user.id, user, null);
//       }
//       Navigator.pop(context);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.user == null ? 'Create User' : 'Edit User')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _fullNameController,
//                 decoration: const InputDecoration(labelText: 'Full Name'),
//                 validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
//               ),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(labelText: 'Email'),
//                 validator: (value) => value!.isEmpty ? 'Please enter an email' : null,
//               ),
//               DropdownButtonFormField<String>(
//                 value: _gender,
//                 items: ['Male', 'Female', 'Other']
//                     .map((label) => DropdownMenuItem(
//                   value: label,
//                   child: Text(label),
//                 ))
//                     .toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _gender = value!;
//                   });
//                 },
//                 decoration: const InputDecoration(labelText: 'Gender'),
//               ),
//               DropdownButtonFormField<Role>(
//                 value: _role,
//                 items: Role.values
//                     .map((role) => DropdownMenuItem(
//                   value: role,
//                   child: Text(role.toString().split('.').last),
//                 ))
//                     .toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _role = value!;
//                   });
//                 },
//                 decoration: const InputDecoration(labelText: 'Role'),
//               ),
//               ElevatedButton(
//                 onPressed: _saveUser,
//                 child: Text(widget.user == null ? 'Create' : 'Update'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

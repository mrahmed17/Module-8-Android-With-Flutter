import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test_final/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:radio_group_v2/radio_group_v2.dart';

class Registration extends StatefulWidget {
  Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController nameTEC = TextEditingController()
    ..text = 'John Doe';
  final TextEditingController emailTEC = TextEditingController()
    ..text = 'pDwKd@example.com';
  final TextEditingController passwordTEC = TextEditingController()
    ..text = 'password';
  final TextEditingController confirmPasswordTEC = TextEditingController()
    ..text = 'password';
  final TextEditingController cellTEC = TextEditingController()
    ..text = '01700000012';
  final TextEditingController addressTEC = TextEditingController()
    ..text = 'Dhaka, Bangladesh';
  final TextEditingController dobTEC = TextEditingController()
    ..text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final TextEditingController statusTEC = TextEditingController()
    ..text = 'Active';
  final RadioGroupController genderController = RadioGroupController();

  DateTime? selectedDate;
  Role? selectedRole;
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> submitRegistration() async {
    final user = {
      'name': nameTEC.text,
      'email': emailTEC.text,
      'cell': cellTEC.text,
      'address': addressTEC.text,
      'dateOfBirth': dobTEC.text,
      'status': statusTEC.text,
      'role': selectedRole?.name,
      'gender': genderController.value,
    };

    var uri = Uri.parse('http://10.0.2.2/api/user/save');
    var request = http.MultipartRequest('POST', uri);

    request.files.add(
      http.MultipartFile.fromString(
        'user',
        jsonEncode(user),
        contentType: MediaType('application', 'json'),
      ),
    );

    if (selectedImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath('avatar', selectedImage!.path),
      );
    }
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Registration successful');
      } else {
        print('Failed to register. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while submitting: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Registration",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: nameTEC,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
                icon: Icon(Icons.person),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailTEC,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                icon: Icon(Icons.email),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordTEC,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                icon: Icon(Icons.password),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: confirmPasswordTEC,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
                icon: Icon(Icons.password),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: cellTEC,
              decoration: const InputDecoration(
                labelText: "Cell Number",
                border: OutlineInputBorder(),
                icon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: addressTEC,
              decoration: const InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(),
                icon: Icon(Icons.location_city),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != selectedDate) {
                  setState(() {
                    selectedDate = picked;
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(selectedDate!);
                    dobTEC.text = formattedDate;
                  });
                }
              },
              controller: dobTEC,
              decoration: const InputDecoration(
                labelText: "Date of Birth",
                border: OutlineInputBorder(),
                icon: Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text("Gender"),
            const SizedBox(
              height: 10,
            ),
            RadioGroup(
              controller: genderController,
              values: ["Male", "Female", "Others"],
              indexOfDefault: 0,
              orientation: RadioGroupOrientation.horizontal,
              decoration: RadioGroupDecoration(
                spacing: 10.0,
                labelStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                activeColor: Colors.blue,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.image),
              label: Text('Pick Avatar'),
              onPressed: pickImage,
            ),
            const SizedBox(
              height: 10,
            ),
            Text("Role"),
            const SizedBox(
              height: 10,
            ),
            DropdownButton<Role>(
              value: selectedRole,
              hint: const Text("Select Role"),
              items: Role.values.map((Role role) {
                return DropdownMenuItem<Role>(
                  value: role,
                  child: Text(role.name),
                );
              }).toList(),
              onChanged: (Role? newValue) {
                setState(() {
                  selectedRole = newValue;
                });
              },
              isExpanded: true,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: submitRegistration,
              child: const Text(
                "Registration",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:date_field/date_field.dart';
import 'package:hr_and_pms/features/administration/screen/LoginPage.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController cell = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController profilePhoto = TextEditingController();
  final TextEditingController basicSalary = TextEditingController();
  // final DateTimeFieldPickerPlatform dob = DateTimeFieldPickerPlatform.material;
  // final TextEditingController gender = TextEditingController();
  DateTime? selectedDOB;
  String? selectedGender;
  String? selectedRole = "Employee";
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  // // Method to validate form and check passwords
  // void _register() {
  //   if (_formKey.currentState!.validate()) {
  //     String uName = name.text;
  //     String uEmail = email.text;
  //     String uPassword = password.text;
  //  // Registration logic goes here (e.g., sending data to server)
  //     print("Name: $uName, Email: $uEmail, Password: $uPassword");
  //   }
  // }

// Method to validate form and check passwords
  void _register() async {
    if (_formKey.currentState!.validate()) {
      String uName = name.text;
      String uEmail = email.text;
      String uPassword = password.text;
      String uCell = cell.text;
      String uAddress = address.text;
      String uProfilePhoto = profilePhoto.text;
      String uGender = selectedGender ?? "Other";
      String uDob = selectedDOB != null ? selectedDOB!.toIso8601String() : '';
      String uBasicSalary = basicSalary.text;
      String uRole = selectedRole ?? "Employee";

      // Start loading indicator
      setState(() {
        isLoading = true;
      });

      // Send data to the server
      final response = await _sendDataToBackend(
          uName, uEmail, uPassword, uCell, uAddress, uProfilePhoto, uGender, uDob, uBasicSalary, uRole
      );

      setState(() {
        isLoading = false;
      });


      if (response.statusCode == 201 || response.statusCode == 200) {
        print("Registration successful!");
        // Navigate to login page after successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else if (response.statusCode == 409) {
        print("Employee already exists!");
        // Handle duplicate registration (e.g., show an alert or message)
      } else {
        print("Registration failed with status: ${response.statusCode}");
        // Handle registration failure (e.g., show an error message)
      }
    }
  }

  // HTTP post request to send data to backend
  Future<http.Response> _sendDataToBackend(
      String name,
      String email,
      String password,
      String cell,
      String address,
      String profilePhoto,
      String gender,
      String dob,
      String basicSalary,
      String role
      ) async {
    const String url = 'http://localhost:8080/register'; // Android emulator
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "cell": cell,
        "address": address,
        "profilePhoto": profilePhoto,
        "gender": gender,
        "dob": dob,
        "basicSalary": basicSalary,
        "role": role,
      }),
    );
    return response;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                      labelText: "Full name",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Full name is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                      labelText: "Enter email address",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')
                        .hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Enter your password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: confirmPassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Confirm password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock)),
                  validator: (value) {
                    if (value != password.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: cell,
                  decoration: const InputDecoration(
                      labelText: "Enter your cell number",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Cell number is required";
                    }
                    if (!RegExp(r'^[+]?[0-9]{10,15}$').hasMatch(value)) {
                      return "Enter a valid cell number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: address,
                  decoration: const InputDecoration(
                      labelText: "Enter your address",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.maps_home_work_rounded)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Address is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: profilePhoto,
                  decoration: const InputDecoration(
                      labelText: "Profile Photo URL",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.photo)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Profile photo URL is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: basicSalary,
                  decoration: const InputDecoration(
                      labelText: "Basic Salary",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.monetization_on)),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Basic salary is required";
                    }
                    if (double.tryParse(value) == null) {
                      return "Enter a valid salary";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DateTimeFormField(
                  decoration: const InputDecoration(labelText: "Select Date of Birth"),
                  mode: DateTimeFieldPickerMode.date,
                  onChanged: (DateTime? value) {
                    setState(() {
                      selectedDOB = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text("Gender"),
                    Expanded(
                      child: Row(
                        children: [
                          Radio<String>(
                            value: "Male",
                            groupValue: selectedGender,
                            onChanged: (String? value) {
                              setState(() {
                                selectedGender = value;
                              });
                            },
                          ),
                          const Text("Male"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Radio<String>(
                            value: "Female",
                            groupValue: selectedGender,
                            onChanged: (String? value) {
                              setState(() {
                                selectedGender = value;
                              });
                            },
                          ),
                          const Text("Female"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Radio<String>(
                            value: "Other",
                            groupValue: selectedGender,
                            onChanged: (String? value) {
                              setState(() {
                                selectedGender = value;
                              });
                            },
                          ),
                          const Text("Other"),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                isLoading
                    ? CircularProgressIndicator() // Show loading indicator when registering
                    : ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white),
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: const Text(
                    "Already have an account? Login here",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
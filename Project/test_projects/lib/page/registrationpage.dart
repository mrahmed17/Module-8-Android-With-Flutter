import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:test_projects/page/loginpage.dart';

class RegistrationPage extends StatefulWidget {

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final TextEditingController name = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController confirmPassword = TextEditingController();

  final TextEditingController cell = TextEditingController();

  final TextEditingController address = TextEditingController();

  final DateTimeFieldPickerPlatform dob = DateTimeFieldPickerPlatform.material;

  // final TextEditingController gender = TextEditingController();

  DateTime? selectedDOB;

  String? selectedGender;

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
      String uCell = password.text;
      String uAddress = password.text;
      String uGender = selectedGender ?? "Other";
      String uDob = selectedDOB != null ? selectedDOB!.toIso8601String() : '';

      //send data to the server
      final response = await _sendDataToBackend(
          uName,
          uEmail,
          uPassword,
          uCell,
          uAddress,
          uGender,
          uDob);

      if (response.statusCode == 201 || response.statusCode == 200) {
        print("Registration successful!");
      } else if (response.statusCode == 409) {
        print("User already exists!");
      } else {
        print("Registration failed with status: ${response.statusCode}");
      }
    }
  }

  //Http post Request to send data to backend
  Future<http.Response> _sendDataToBackend(String name,
      String email,
      String password,
      String cell,
      String address,
      String gender,
      String dob) async {
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
        "gender": gender,
        "dob": dob,
      }),
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: name,
                  decoration: const InputDecoration(
                      labelText: "Full name",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: email,
                  decoration: const InputDecoration(
                      labelText: "Enter email address",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: password,
                  decoration: const InputDecoration(
                      labelText: "Enter your password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock)),
                  obscureText: true,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: confirmPassword,
                  decoration: InputDecoration(
                      labelText: "Confirm password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock)),
                  obscureText: true,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: cell,
                  decoration: InputDecoration(
                      labelText: "Enter your cell number",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: address,
                  decoration: InputDecoration(
                      labelText: "Enter your address",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.maps_home_work_rounded)),
                ),
                SizedBox(height: 20),
                DateTimeFormField(
                  decoration:
                  InputDecoration(labelText: "Select Date of birth"),
                  mode: DateTimeFieldPickerMode.date,
                  pickerPlatform: dob,
                  onChanged: (DateTime? value) {
                    print(value);
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text("Gender"),
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
                              }),
                          Text("Male"),
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
                          Text("Female"),
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
                          Text("Other")
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    _register();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white),
                  child: Text(
                    "Registration",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: GoogleFonts
                            .roboto()
                            .fontFamily),
                  ),
                ),
                SizedBox(height: 20,),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    }, child: Text("Login", style: TextStyle(
                  color: Colors.cyanAccent,
                  decoration: TextDecoration.underline,
                ),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

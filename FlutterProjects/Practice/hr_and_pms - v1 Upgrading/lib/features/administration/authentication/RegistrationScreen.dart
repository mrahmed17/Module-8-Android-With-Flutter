import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:hr_and_pms/features/administration/authentication/LoginScreen.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:image_picker_web/image_picker_web.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController name = TextEditingController()..text = 'TEST';
  final TextEditingController email = TextEditingController()..text = 'test@test.com';
  final TextEditingController password = TextEditingController()..text = '123456';
  final TextEditingController confirmPassword = TextEditingController()..text = '123456';
  final TextEditingController cell = TextEditingController()..text = '01700000000';
  final TextEditingController address = TextEditingController()..text = 'OMG';
  final TextEditingController basicSalary = TextEditingController()..text = '5000';
  DateTime? selectedDOB;
  DateTime? joinedDate = DateTime.now(); // Automatically set joining date
  String? selectedGender;
  String? selectedRole = "EMPLOYEE";
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  XFile? mobilePhoto;
  Uint8List? webPhoto;

  Future<void> pickImage() async {
    if (kIsWeb) {
      var pickedImage = await ImagePickerWeb.getImageAsBytes();
      if (pickedImage != null) {
        setState(() {
          webPhoto = pickedImage;
        });
      }
    } else {
      final XFile? pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          mobilePhoto = pickedImage;
        });
      }
    }
  }

  // Method to register user
  void _register() async {
    if (_formKey.currentState!.validate()) {
      final user = {
        'name': name.text,
        'email': email.text,
        'password': password.text,
        'cell': cell.text,
        'address': address.text,
        'dateOfBirth':
        selectedDOB != null ? selectedDOB!.toIso8601String() : '',
        'gender': selectedGender ?? "Other",
        'basicSalary': basicSalary.text,
        'joinedDate': joinedDate!.toIso8601String(), // Set the joining date to current date
        'role': selectedRole ?? "EMPLOYEE",
      };

      setState(() {
        isLoading = true;
      });

      final response = await _sendDataToBackend(user);

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 201 || response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        print("Registration failed with status: ${response.statusCode}");
      }
    }
  }

  Future<http.Response> _sendDataToBackend(Map<String, String> user) async {
    const String url = 'http://localhost:8080/register';
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.add(
      http.MultipartFile.fromString(
        'user',
        jsonEncode(user),
        contentType: MediaType('application', 'json'),
      ),
    );

    if (kIsWeb && webPhoto != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'profilePhoto',
        webPhoto!,
        filename: 'upload.jpg',
        contentType: MediaType('image', 'jpeg'),
      ));
    } else if (mobilePhoto != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'profilePhoto',
        mobilePhoto!.path,
      ));
    }

    final response = await request.send();
    return await http.Response.fromStream(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,),),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTextField(name, 'Full name', Icons.person),
                const SizedBox(height: 20),
                _buildTextField(email, 'Email', Icons.email),
                const SizedBox(height: 20),
                _buildTextField(password, 'Password', Icons.lock, obscureText: true),
                const SizedBox(height: 20),
                _buildTextField(confirmPassword, 'Confirm password', Icons.lock, obscureText: true),
                const SizedBox(height: 20),
                _buildTextField(cell, 'Cell number', Icons.phone),
                const SizedBox(height: 20),
                _buildTextField(address, 'Address', Icons.home),
                const SizedBox(height: 20),
                DateTimeFormField(
                  decoration: const InputDecoration(
                    labelText: "Select Date of Birth",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today, color: Colors.teal,),
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  onChanged: (DateTime? value) {
                    setState(() {
                      selectedDOB = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  items: ['Male', 'Female', 'Other']
                      .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "Gender",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.people, color: Colors.teal,),
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(basicSalary, 'basicSalary', Icons.currency_exchange),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: pickImage,
                  child: Container(
                    color: Colors.grey[200],
                    height: 150,
                    width: double.infinity,
                    child: webPhoto != null
                        ? Image.memory(webPhoto!, fit: BoxFit.cover)
                        : mobilePhoto != null
                        ? Image.file(File(mobilePhoto!.path), fit: BoxFit.cover)
                        : Icon(Icons.add_photo_alternate_outlined, color: Colors.grey[700], size: 50),
                  ),
                ),
                const SizedBox(height: 30),
                isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  ),
                  child: const Text("Register", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: const Text(
                    "Already have an account? Login here",
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to create TextFormField with consistent styling
  Widget _buildTextField(TextEditingController controller, String label, IconData icon,
      {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.teal),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
        ),
      ),
      validator: (value) => value == null || value.isEmpty ? "$label is required" : null,
    );
  }
}

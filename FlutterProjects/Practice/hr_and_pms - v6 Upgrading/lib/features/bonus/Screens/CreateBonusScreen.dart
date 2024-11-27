import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_and_pms/administration/model/User.dart';
import 'package:hr_and_pms/administration/service/AuthService.dart';
import 'package:hr_and_pms/features/bonus/model/Bonus.dart';
import 'package:hr_and_pms/features/bonus/service/BonusService.dart';

class CreateBonusScreen extends StatefulWidget {
  const CreateBonusScreen({super.key});

  @override
  _CreateBonusScreenState createState() => _CreateBonusScreenState();
}

class _CreateBonusScreenState extends State<CreateBonusScreen> {
  final _formKey = GlobalKey()<FormState>;
  double? _bonusAmount;
  User? _selectedEmployee;
  final AuthService _authService = AuthService();
  final BonusService _bonusService = BonusService();
  List<User> _employees = [];

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
  }

  // Method to fetch the list of employees (users) from the AuthService
  Future<void> _fetchEmployees() async {
    try {
      // Fetch users (employees) using AuthService
      _employees = await _authService.getAllUsers();
      setState(() {});
    } catch (e) {
      print("Error fetching employees: $e");
    }
  }

  // Method to create a bonus
  Future<void> _createBonus() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      if (_selectedEmployee == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select an employee'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Create Bonus object
      Bonus bonus = Bonus(
        bonusAmount: _bonusAmount,
        user: _selectedEmployee,
      );

      try {
        // Create bonus by calling BonusService
        await _bonusService.createBonus(bonus);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bonus created successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); // Go back after creating bonus
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create bonus: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Bonus'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Icon Section
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.teal[100],
                    child: Icon(
                      Icons.money,
                      size: 40,
                      color: Colors.teal[700],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Select Employee Dropdown
                DropdownButtonFormField<User>(
                  decoration: InputDecoration(
                    labelText: 'Select Employee',
                    labelStyle: TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                  ),
                  items: _employees.map((user) {
                    return DropdownMenuItem(
                      value: user,
                      child: Text(user.name ?? 'No name'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedEmployee = value;
                    });
                  },
                  validator: (value) =>
                  value == null ? 'Please select an employee' : null,
                ),
                const SizedBox(height: 20),

                // Bonus Amount Input Field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Bonus Amount',
                    labelStyle: TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    prefixIcon: Icon(Icons.attach_money, color: Colors.teal),
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _bonusAmount = double.tryParse(value!),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a bonus amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Reason Input Field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Reason',
                    labelStyle: TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    prefixIcon: Icon(Icons.note, color: Colors.teal),
                  ),),
                const SizedBox(height: 30),

                // Submit Button
                ElevatedButton(
                  onPressed: _createBonus,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'Create Bonus',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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

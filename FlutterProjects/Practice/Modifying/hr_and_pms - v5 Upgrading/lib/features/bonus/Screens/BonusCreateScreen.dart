import 'package:flutter/material.dart';
import 'package:hr_and_pms/administration/model/User.dart';import 'package:hr_and_pms/administration/service/UserService.dart';
import 'package:hr_and_pms/features/bonus/model/Bonus.dart';
import 'package:hr_and_pms/features/bonus/model/BonusType.dart';
import 'package:hr_and_pms/features/bonus/service/BonusService.dart';

class BonusCreateScreen extends StatefulWidget {
  const BonusCreateScreen({Key? key}) : super(key: key);

  @override
  State<BonusCreateScreen> createState() => _BonusCreateScreenState();
}

class _BonusCreateScreenState extends State<BonusCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final BonusService _bonusService = BonusService();
  final UserService _userService = UserService();

  double _bonusAmount = 0.0;
  DateTime _bonusDate = DateTime.now();
  BonusType? _bonusType;
  User? _selectedUser;
  List<User> _employees = []; // To store fetched employees
  String _statusMessage = '';

  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
  }

  // Fetch all employees with the EMPLOYEE role
  Future<void> _fetchEmployees() async {
    try {
      List<User>? users = await _userService.getAllEmployees(5, 10);
      if (users != null) {
        setState(() {
          _employees = users;
        });
        debugPrint("Fetched employees: ${_employees.map((e) => e.name).toList()}");
      } else {
        debugPrint("No employees found.");
      }
    } catch (e) {
      debugPrint("Error fetching employees: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Bonus'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bonus Amount Field
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Bonus Amount',
                    labelStyle: const TextStyle(color: Colors.teal),
                    prefixIcon: const Icon(Icons.attach_money, color: Colors.teal),
                    filled: true,
                    fillColor: Colors.teal[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) {
                    setState(() {
                      _bonusAmount = double.tryParse(value) ?? 0.0;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a bonus amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Bonus Date Field
                GestureDetector(
                  onTap: _selectDate,
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Bonus Date',
                        labelStyle: const TextStyle(color: Colors.teal),
                        prefixIcon: const Icon(Icons.date_range, color: Colors.teal),
                        filled: true,
                        fillColor: Colors.teal[50],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      controller: TextEditingController(
                        text: _bonusDate.toLocal().toString().split(' ')[0],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a bonus date';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Bonus Type Dropdown
                DropdownButtonFormField<BonusType>(
                  decoration: InputDecoration(
                    labelText: 'Bonus Type',
                    labelStyle: const TextStyle(color: Colors.teal),
                    filled: true,
                    fillColor: Colors.teal[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  value: _bonusType,
                  items: BonusType.values.map((BonusType type) {
                    return DropdownMenuItem<BonusType>(
                      value: type,
                      child: Text(type.toShortString()),
                    );
                  }).toList(),
                  onChanged: (BonusType? newType) {
                    setState(() {
                      _bonusType = newType;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a bonus type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Employee Dropdown
              DropdownButtonFormField<User>(
                decoration: InputDecoration(
                  labelText: 'Employee',
                  labelStyle: const TextStyle(color: Colors.teal),
                  filled: true,
                  fillColor: Colors.teal[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                value: _selectedUser,
                items: _employees.isNotEmpty
                    ? _employees.map((user) {
                  return DropdownMenuItem<User>(
                    value: user,
                    child: Text(user.name),
                  );
                }).toList()
                    : null,
                onChanged: (User? newUser) {
                  setState(() {
                    _selectedUser = newUser;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select an employee';
                  }
                  return null;
                },
                hint: _employees.isEmpty ? Text('No employees available') : null,
              ),
              const SizedBox(height: 24),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _createBonus,
                    child: const Text(
                      'Create Bonus',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Status Message
                if (_statusMessage.isNotEmpty)
                  Center(
                    child: Text(
                      _statusMessage,
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 16,
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

  // Date Picker for selecting date
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _bonusDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _bonusDate) {
      setState(() {
        _bonusDate = picked;
      });
    }
  }

  // Method to create the bonus
  Future<void> _createBonus() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _statusMessage = 'Creating bonus...';
      });

      Bonus bonus = Bonus(
        bonusAmount: _bonusAmount,
        bonusDate: _bonusDate,
        bonusType: _bonusType!,
        user: _selectedUser!,
      );

      Bonus? createdBonus = await _bonusService.createBonus(bonus);

      setState(() {
        _statusMessage = createdBonus != null
            ? 'Bonus created successfully!'
            : 'Error creating bonus. Please try again.';
      });
    }
  }
}

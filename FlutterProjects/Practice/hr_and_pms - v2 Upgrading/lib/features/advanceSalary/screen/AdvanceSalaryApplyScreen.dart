import 'package:flutter/material.dart';
import 'package:hr_and_pms/administration/model/User.dart';
import 'package:hr_and_pms/features/advanceSalary/model/AdvanceSalary.dart';
import 'package:intl/intl.dart';

class AdvanceSalaryApplyScreen extends StatefulWidget {
  const AdvanceSalaryApplyScreen({Key? key}) : super(key: key);

  @override
  State<AdvanceSalaryApplyScreen> createState() => _AdvanceSalaryApplyScreenState();
}

class _AdvanceSalaryApplyScreenState extends State<AdvanceSalaryApplyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _advanceSalaryController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _applyForAdvanceSalary() {
    if (_formKey.currentState!.validate()) {
      // Mock user object. Replace with the actual logged-in user.
      final user = User.empty();
      final advanceSalary = AdvanceSalary(
        id: 0, // ID will be assigned by the backend
        advanceSalary: double.parse(_advanceSalaryController.text),
        reason: _reasonController.text,
        advanceDate: _selectedDate,
        user: user,
      );

      // Call the service to create advance salary
      // AdvanceSalaryService().createAdvanceSalary(advanceSalary);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Advance Salary application submitted')),
      );
    }
  }

  void _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply for Advance Salary'),
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
                const Text(
                  'Advance Salary Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _advanceSalaryController,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _reasonController,
                  decoration: const InputDecoration(
                    labelText: 'Reason',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide a reason';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Advance Date: ${DateFormat.yMMMd().format(_selectedDate)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _pickDate(context),
                      icon: const Icon(Icons.calendar_today, color: Colors.teal),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: _applyForAdvanceSalary,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Submit Application',
                      style: TextStyle(fontSize: 16),
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

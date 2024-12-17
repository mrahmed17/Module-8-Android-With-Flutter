import 'package:flutter/material.dart';
import 'package:hr_and_pms/features/salary/service/SalaryService.dart';
import 'package:hr_and_pms/features/salary/model/Salary.dart';

class SalaryCreateScreen extends StatefulWidget {
  const SalaryCreateScreen({Key? key}) : super(key: key);

  @override
  _SalaryCreateScreenState createState() => _SalaryCreateScreenState();
}

class _SalaryCreateScreenState extends State<SalaryCreateScreen> {
  final SalaryService _salaryService = SalaryService();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userIdController = TextEditingController();

  bool _isLoading = false;
  Salary? _createdSalary;

  // Handles salary creation
  Future<void> _createSalary() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _createdSalary = null;
    });

    try {
      final userId = int.parse(_userIdController.text);
      final salary = await _salaryService.calculateAndSaveSalary(userId);

      setState(() {
        _createdSalary = salary;
      });

      if (salary != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Salary created successfully!')),
        );
        _userIdController.clear(); // Clear the user ID field after success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create salary.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Salary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // User ID Input
              TextFormField(
                controller: _userIdController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'User ID',
                  hintText: 'Enter the user ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a user ID';
                  }
                  if (int.tryParse(value) == null) {
                    return 'User ID must be a number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: _isLoading ? null : _createSalary,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Create Salary'),
              ),

              const SizedBox(height: 30),

              // Display Created Salary
              if (_createdSalary != null) ...[
                const Text(
                  'Salary Created Successfully!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'User ID: ${_createdSalary?.id}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Net Salary: \$${_createdSalary?.netSalary.toStringAsFixed(2) ?? "N/A"}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Tax: \$${_createdSalary?.tax.toStringAsFixed(2) ?? "N/A"}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Provident Fund: \$${_createdSalary?.providentFund.toStringAsFixed(2) ?? "N/A"}',
                  style: const TextStyle(fontSize: 16),
                ),
                // Text(
                //   'Total Salary: \$${_createdSalary?.totalSalary?.toStringAsFixed(2) ?? "N/A"}',
                //   style: const TextStyle(fontSize: 16),
                // ),
                Text(
                  'Payment Date: ${_createdSalary?.paymentDate.toLocal().toString().split(' ')[0]}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:hr_and_pms/administration/service/AuthService.dart';
import 'package:hr_and_pms/features/advanceSalary/model/AdvanceSalary.dart';
import 'package:hr_and_pms/features/advanceSalary/service/AdvanceSalaryService.dart';
import 'package:hr_and_pms/features/leave/model/RequestStatus.dart';

class ApplyAdvanceSalaryScreen extends StatefulWidget {
  @override
  _ApplyAdvanceSalaryScreenState createState() =>
      _ApplyAdvanceSalaryScreenState();
}

class _ApplyAdvanceSalaryScreenState extends State<ApplyAdvanceSalaryScreen> {
  final _formKey = GlobalKey<FormState>();
  double? _amount;
  String? _reason;
  final RequestStatus _requestStatus = RequestStatus.PENDING;
  final AdvanceSalaryService _advanceSalaryService = AdvanceSalaryService();

  Future<void> _saveAdvanceSalaryRequest() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final user = await AuthService().getUser();
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unable to fetch user details')),
        );
        return;
      }

      AdvanceSalary advanceSalary = AdvanceSalary(
        advanceAmount: _amount,
        reason: _reason,
        advanceDate: DateTime.now(),
        status: _requestStatus,
        user: user,
      );

      try {
        await _advanceSalaryService.applyAdvanceSalary(advanceSalary);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Advance salary request submitted successfully')),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit request: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Advance Salary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _amount = double.tryParse(value!),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Reason'),
                maxLines: 3,
                onSaved: (value) => _reason = value,
                validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter a reason' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveAdvanceSalaryRequest,
                child: const Text('Submit Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

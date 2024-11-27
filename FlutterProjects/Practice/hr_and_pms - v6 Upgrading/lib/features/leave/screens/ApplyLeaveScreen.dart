import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hr_and_pms/administration/service/AuthService.dart';
import 'package:hr_and_pms/features/leave/model/Leave.dart';
import 'package:hr_and_pms/features/leave/model/LeaveType.dart';
import 'package:hr_and_pms/features/leave/model/RequestStatus.dart';
import 'package:hr_and_pms/features/leave/service/LeaveService.dart';

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({super.key});

  @override
  _ApplyLeaveScreenState createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _startDate;
  DateTime? _endDate;
  String? _reason;
  LeaveType? _leaveType;
  final RequestStatus _requestStatus = RequestStatus.PENDING;
  final LeaveService _leaveService = LeaveService();
  bool _isLoading = false;

  Future<void> _saveLeaveRequest() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      if (_startDate == null || _endDate == null) {
        _showSnackBar('Please select both start and end dates', Colors.red);
        return;
      }

      if (_startDate!.isAfter(_endDate!)) {
        _showSnackBar('Start date cannot be after end date', Colors.red);
        return;
      }

      if (_startDate!.isBefore(DateTime.now())) {
        _showSnackBar('Start date cannot be in the past', Colors.red);
        return;
      }

      setState(() => _isLoading = true);

      try {
        final userData = await AuthService().getUser();
        if (userData == null) throw Exception('Unable to fetch user details');

        Leave leave = Leave(
          startDate: _startDate!,
          endDate: _endDate!,
          reason: _reason!,
          leaveType: _leaveType!,
          requestStatus: _requestStatus,
          requestDate: DateTime.now(),
          user: userData,
        );

        await _leaveService.applyLeave(leave, userData.id);
        _showSnackBar('Leave request submitted successfully', Colors.green);
        Navigator.pop(context, true);
      } catch (e) {
        _showSnackBar('Failed to submit leave request: ${e.toString()}', Colors.red);
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: backgroundColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Request Leave',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 4,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB2DFDB), Color(0xFFE0F2F1)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView(
                        children: [
                          Text(
                            'Request Leave',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal[800],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Reason',
                              prefixIcon: const Icon(Icons.edit, color: Colors.teal),
                              labelStyle: const TextStyle(fontSize: 16, color: Colors.teal),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(color: Colors.teal),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(color: Colors.teal, width: 2),
                              ),
                            ),
                            onSaved: (value) => _reason = value,
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Please enter a reason';
                              if (value.length > 250) return 'Reason should not exceed 250 characters';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            title: const Text('Start Date'),
                            subtitle: Text(
                              _startDate != null
                                  ? DateFormat('yyyy-MM-dd').format(_startDate!)
                                  : 'Select Start Date',
                              style: const TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                            trailing: const Icon(Icons.date_range, color: Colors.teal),
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: _startDate ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) {
                                setState(() => _startDate = picked);
                              }
                            },
                          ),
                          const Divider(color: Colors.teal),
                          ListTile(
                            title: const Text('End Date'),
                            subtitle: Text(
                              _endDate != null
                                  ? DateFormat('yyyy-MM-dd').format(_endDate!)
                                  : 'Select End Date',
                              style: const TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                            trailing: const Icon(Icons.date_range, color: Colors.teal),
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: _endDate ?? DateTime.now(),
                                firstDate: _startDate ?? DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) {
                                setState(() => _endDate = picked);
                              }
                            },
                          ),
                          const Divider(color: Colors.teal),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<LeaveType>(
                            hint: const Text('Select Leave Type'),
                            value: _leaveType,
                            onChanged: (LeaveType? newValue) {
                              setState(() => _leaveType = newValue);
                            },
                            items: LeaveType.values.map<DropdownMenuItem<LeaveType>>((LeaveType value) {
                              return DropdownMenuItem<LeaveType>(
                                value: value,
                                child: Text(value.toShortString()),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              labelText: 'Leave Type',
                              prefixIcon: const Icon(Icons.category, color: Colors.teal),
                              labelStyle: const TextStyle(fontSize: 16, color: Colors.teal),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(color: Colors.teal),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(color: Colors.teal, width: 2),
                              ),
                            ),
                            validator: (value) => value == null ? 'Please select a leave type' : null,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _saveLeaveRequest,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'Submit Leave Request',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

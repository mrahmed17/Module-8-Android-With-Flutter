import 'package:flutter/material.dart';
import 'package:hr_and_pms/administration/service/AuthService.dart';
import 'package:hr_and_pms/features/leave/model/Leave.dart';
import 'package:hr_and_pms/features/leave/model/LeaveType.dart';
import 'package:hr_and_pms/features/leave/model/RequestStatus.dart';
import 'package:hr_and_pms/features/leave/service/LeaveService.dart';

class ApplyLeaveScreen extends StatefulWidget {
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

  @override
  void initState() {
    super.initState();
  }

  Future<void> _saveLeaveRequest() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      if (_startDate == null || _endDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select both start and end dates')),
        );
        return;
      }

      if (_startDate!.isAfter(_endDate!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Start date cannot be after end date')),
        );
        return;
      }

      final user = await AuthService().getUser();
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unable to fetch user details')),
        );
        return;
      }

      Leave leave = Leave(
        startDate: _startDate,
        endDate: _endDate,
        reason: _reason,
        leaveType: _leaveType,
        requestStatus: _requestStatus,
        user: await AuthService().getUser(),
        requestDate: DateTime.now(),
      );

      try {
        await _leaveService.applyLeave(leave, user.id!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Leave request submitted successfully')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit leave request: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Request Leave',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 4, ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB2DFDB),
              Color(0xFFE0F2F1),],
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
                          prefixIcon: Icon(Icons.edit, color: Colors.teal),
                          labelStyle: TextStyle(fontSize: 16, color: Colors.teal),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.teal, width: 2),
                          ),
                        ),
                        onSaved: (value) => _reason = value,
                        validator: (value) => value?.isEmpty ?? true ? 'Please enter a reason' : null,
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        title: const Text('Start Date'),
                        subtitle: Text(
                          _startDate != null
                              ? _startDate!.toLocal().toString().split(' ')[0]
                              : 'Select Start Date',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        trailing: Icon(Icons.date_range, color: Colors.teal),
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: _startDate ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setState(() {
                              _startDate = picked;
                            });
                          }
                        },
                      ),
                      const Divider(color: Colors.teal),
                      ListTile(
                        title: const Text('End Date'),
                        subtitle: Text(
                          _endDate != null
                              ? _endDate!.toLocal().toString().split(' ')[0]
                              : 'Select End Date',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        trailing: Icon(Icons.date_range, color: Colors.teal),
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: _endDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setState(() {
                              _endDate = picked;
                            });
                          }
                        },
                      ),
                      const Divider(color: Colors.teal),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<LeaveType>(
                        value: _leaveType,
                        onChanged: (LeaveType? newValue) {
                          setState(() {
                            _leaveType = newValue;
                          });
                        },
                        items: LeaveType.values.map<DropdownMenuItem<LeaveType>>(
                              (LeaveType value) {
                            return DropdownMenuItem<LeaveType>(
                              value: value,
                              child: Text(value.toShortString()),
                            );
                          },
                        ).toList(),
                        decoration: InputDecoration(
                          labelText: 'Leave Type',
                          prefixIcon: Icon(Icons.category, color: Colors.teal),
                          labelStyle: TextStyle(fontSize: 16, color: Colors.teal),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.teal, width: 2),
                          ),
                        ),
                        validator: (value) =>
                        value == null ? 'Please select a leave type' : null,
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
    );
  }
}

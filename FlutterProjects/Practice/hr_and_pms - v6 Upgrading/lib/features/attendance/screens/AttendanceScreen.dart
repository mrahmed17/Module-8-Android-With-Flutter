import 'package:flutter/material.dart';
import 'package:hr_and_pms/features/attendance/model/AttendanceModel.dart';
import 'package:hr_and_pms/features/attendance/service/AttendanceService.dart';
import 'package:hr_and_pms/administration/service/AuthService.dart';
import 'package:hr_and_pms/administration/model/User.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final AttendanceService _attendanceService = AttendanceService();
  final _formKey = GlobalKey<FormState>();
  DateTime? _clockInTime;
  DateTime? _clockOutTime;
  bool? _lateCheckIn;
  User? _currentUser;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _currentUser = (await AuthService().getUser());
    } catch (e) {
      _showNotification('Failed to load user: $e', isSuccess: false);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showNotification(String message, {bool isSuccess = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green[300] : Colors.red[300],
      ),
    );
  }

  Future<void> _checkIn() async {
    if (_currentUser == null) return;
    setState(() {
      _isLoading = true;
    });

    try {
      Attendance? attendance = await _attendanceService.checkIn(_currentUser!.id);
      setState(() {
        _clockInTime = attendance?.clockInTime;
        _lateCheckIn = attendance?.lateCheckIn;
      });
      _showNotification('Check-in successful at $_clockInTime');
    } catch (e) {
      _showNotification('Failed to check in: $e', isSuccess: false);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _checkOut() async {
    if (_currentUser == null) return;
    setState(() {
      _isLoading = true;
    });

    try {
      Attendance? attendance = await _attendanceService.checkOut(_currentUser!.id);
      setState(() {
        _clockOutTime = attendance?.clockOutTime;
      });
      _showNotification('Check-out successful at $_clockOutTime');
    } catch (e) {
      _showNotification('Failed to check out: $e', isSuccess: false);
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
        title: const Text(
          'Attendance System',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 4,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Welcome, ${_currentUser?.name ?? 'User'}!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      _buildDetailTile(
                        title: 'Clock-In Time',
                        value: _clockInTime != null
                            ? _clockInTime!.toString()
                            : 'Not checked in yet',
                        icon: Icons.access_time,
                      ),
                      const SizedBox(height: 10),
                      _buildDetailTile(
                        title: 'Clock-Out Time',
                        value: _clockOutTime != null
                            ? _clockOutTime!.toString()
                            : 'Not checked out yet',
                        icon: Icons.exit_to_app,
                      ),
                      const SizedBox(height: 10),
                      _buildDetailTile(
                        title: 'Late Check-In',
                        value: _lateCheckIn != null
                            ? (_lateCheckIn! ? 'Yes' : 'No')
                            : 'Not checked in yet',
                        icon: Icons.warning,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  'Check In',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _checkOut,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  'Check Out',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailTile({required String title, required String value, required IconData icon}) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}

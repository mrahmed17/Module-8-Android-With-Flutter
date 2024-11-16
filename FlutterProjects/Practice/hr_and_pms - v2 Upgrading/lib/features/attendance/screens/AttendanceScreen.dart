import 'package:flutter/material.dart';
import 'package:hr_and_pms/features/attendance/model/AttendanceModel.dart';
import 'package:hr_and_pms/features/attendance/service/AttendanceService.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final AttendanceService attendanceService = AttendanceService();
  Attendance? todayAttendance;
  bool isLoading = false;
  int selectedUserId = 1; // Replace with actual logged-in user ID.

  @override
  void initState() {
    super.initState();
    fetchTodayAttendance();
  }

  // Handle check-in action
  Future<void> checkIn() async {
    try {
      final attendance = await attendanceService.checkIn(selectedUserId);
      setState(() => todayAttendance = attendance);
      showSnackBar("Checked in successfully!");
    } catch (e) {
      showSnackBar("Failed to check in. Error: $e");
    }
  }

  // Handle check-out action
  Future<void> checkOut() async {
    try {
      final attendance = await attendanceService.checkOut(selectedUserId);
      setState(() => todayAttendance = attendance);
      showSnackBar("Checked out successfully!");
    } catch (e) {
      showSnackBar("Failed to check out. Error: $e");
    }
  }

  // Fetch today's attendance records
  Future<void> fetchTodayAttendance() async {
    setState(() => isLoading = true);
    try {
      final attendanceRecords = await attendanceService.getTodayAttendanceByUserId(selectedUserId);
      setState(() {
        todayAttendance = attendanceRecords.isNotEmpty ? attendanceRecords.first : null;
      });
    } catch (e) {
      showSnackBar("Failed to load attendance records. Error: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  // Show a snack bar for user feedback
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  // Calculate overtime based on attendance times
  String calculateOvertime(Attendance attendance) {
    final checkIn = attendance.clockInTime;
    final checkOut = attendance.clockOutTime;

    if (checkIn == null || checkOut == null) return "N/A";

    final duration = checkOut.difference(checkIn);
    final overtimeHours = duration.inHours - 8; // Assuming an 8-hour workday
    return overtimeHours > 0 ? "$overtimeHours hours" : "No overtime";
  }

  // Check if the user can check in
  bool canCheckIn() => todayAttendance?.clockInTime == null;

  // Check if the user can check out
  bool canCheckOut() => todayAttendance?.clockInTime != null && todayAttendance?.clockOutTime == null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Attendance Tracker",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: canCheckIn() ? checkIn : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                "Check In",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: canCheckOut() ? checkOut : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                "Check Out",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : todayAttendance != null
                ? buildAttendanceDetails()
                : const Center(
              child: Text(
                "No attendance record for today",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to display attendance details
  Widget buildAttendanceDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Attendance Details",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text("Check-in Time: ${todayAttendance!.clockInTime ?? 'Not Checked In'}"),
        Text("Check-out Time: ${todayAttendance!.clockOutTime ?? 'Not Checked Out'}"),
        Text("Overtime Hours: ${calculateOvertime(todayAttendance!)}"),
      ],
    );
  }
}

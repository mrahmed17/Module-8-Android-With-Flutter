import 'package:flutter/material.dart';
import 'package:hr_and_payroll_management/features/attendance/AttendanceModel.dart';
import 'package:hr_and_payroll_management/features/attendance/AttendanceService.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final AttendanceService attendanceService = AttendanceService();
  List<Attendance> todayAttendance = [];
  bool isLoading = false;
  int selectedUserId = 1; // Default user ID; adjust as needed

  @override
  void initState() {
    super.initState();
    fetchTodayAttendance();
  }

  Future<void> fetchTodayAttendance() async {
    setState(() => isLoading = true);
    try {
      List<Attendance> attendanceRecords = await attendanceService.getTodayAttendance();
      setState(() {
        todayAttendance = attendanceRecords;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load attendance records")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> checkIn() async {
    try {
      await attendanceService.checkIn(selectedUserId);
      await fetchTodayAttendance();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Checked in successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to check in")),
      );
    }
  }

  Future<void> checkOut() async {
    try {
      await attendanceService.checkOut(selectedUserId);
      await fetchTodayAttendance();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Checked out successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to check out")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Attendance"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: checkIn,
                  child: Text("Check In"),
                ),
                ElevatedButton(
                  onPressed: checkOut,
                  child: Text("Check Out"),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Today's Attendance",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : todayAttendance.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: todayAttendance.length,
                itemBuilder: (context, index) {
                  final attendance = todayAttendance[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: Text("${attendance.id}"),
                      title: Text("User: ${attendance.user.fullName}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date: ${attendance.date}"),
                          Text("Check-in: ${attendance.clockInTime ?? 'N/A'}"),
                          Text("Check-out: ${attendance.clockOutTime ?? 'N/A'}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
                : Center(child: Text("No attendance records for today")),
          ],
        ),
      ),
    );
  }
}

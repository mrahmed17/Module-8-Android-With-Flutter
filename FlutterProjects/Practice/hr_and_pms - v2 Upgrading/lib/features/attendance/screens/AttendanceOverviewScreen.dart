import 'package:flutter/material.dart';
import 'package:hr_and_pms/features/attendance/service/AttendanceService.dart';
import 'package:hr_and_pms/features/attendance/model/AttendanceModel.dart';
import 'package:hr_and_pms/features/user/model/User.dart';

class AttendanceOverviewScreen extends StatefulWidget {
  const AttendanceOverviewScreen({super.key});

  @override
  _AttendanceOverviewScreenState createState() =>
      _AttendanceOverviewScreenState();
}

class _AttendanceOverviewScreenState extends State<AttendanceOverviewScreen> {
  final AttendanceService attendanceService = AttendanceService();
  List<Attendance> recentAttendances = [];
  List<User> usersWithoutAttendanceToday = [];
  Map<String, dynamic>? attendanceCountsInRange;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchOverviewData();
  }

  Future<void> fetchOverviewData() async {
    setState(() => isLoading = true);
    try {
      await fetchRecentAttendances();
      await fetchUsersWithoutAttendanceToday();
      await fetchAttendanceCountsInRange(
          DateTime.now().subtract(Duration(days: 30)), DateTime.now());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              "Failed to load overview data",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
            )),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchRecentAttendances() async {
    recentAttendances = await attendanceService.getAllAttendances();
  }

  Future<void> fetchUsersWithoutAttendanceToday() async {
    usersWithoutAttendanceToday =
    await attendanceService.getUsersWithoutAttendanceToday();
  }

  Future<void> fetchAttendanceCountsInRange(
      DateTime startDate, DateTime endDate) async {
    Map<User, int> response = await attendanceService.getUsersAttendanceInRange(startDate, endDate);

    // Convert Map<User, int> to Map<String, dynamic>
    attendanceCountsInRange = {
      for (var entry in response.entries) entry.key.name: entry.value,
    };
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Attendance Overview",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle("Recent Attendances"),
            _buildRecentAttendancesList(),
            SizedBox(height: 20),
            _buildSectionTitle("Users Without Attendance Today"),
            _buildUsersWithoutAttendanceList(),
            SizedBox(height: 20),
            _buildSectionTitle("Attendance Counts in Last 30 Days"),
            _buildAttendanceCounts(),
          ],
        ),
      ),
    );
  }

  // Builds the title for each section
  Widget _buildSectionTitle(String title) {
    return Center(
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
      ),
    );
  }

  // Displays the list of recent attendances or a message if no data is available
  Widget _buildRecentAttendancesList() {
    if (recentAttendances.isEmpty) {
      return Center(
        child: Text(
          "No recent attendances",
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true, // Ensures the list doesn't take up too much space
      physics: NeverScrollableScrollPhysics(), // Prevents scrolling conflicts
      itemCount: recentAttendances.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            "User: ${recentAttendances[index].user.name}",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          subtitle: Text(
            "Check-in: ${recentAttendances[index].clockInTime ?? 'N/A'}, "
                "Check-out: ${recentAttendances[index].clockOutTime ?? 'N/A'}",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
          ),
        );
      },
    );
  }

  // Displays the list of users without attendance today
  Widget _buildUsersWithoutAttendanceList() {
    if (usersWithoutAttendanceToday.isEmpty) {
      return Center(
        child: Text(
          "All users have checked in today",
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: usersWithoutAttendanceToday.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            "User: ${usersWithoutAttendanceToday[index].name}",
          ),
        );
      },
    );
  }

  // Displays the attendance counts or a message if no data is available
  Widget _buildAttendanceCounts() {
    if (attendanceCountsInRange == null) {
      return Center(
        child: Text(
          "No data available for the specified range",
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
      );
    }
    return Text(
      "Total: ${attendanceCountsInRange!['total']} | Present: ${attendanceCountsInRange!['present']} "
          "| Absent: ${attendanceCountsInRange!['absent']}",
      style: TextStyle(fontSize: 16, color: Colors.teal),
    );
  }
}
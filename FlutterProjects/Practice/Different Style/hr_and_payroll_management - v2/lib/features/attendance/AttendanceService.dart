import 'dart:convert';
import 'package:hr_and_payroll_management/features/attendance/AttendanceModel.dart';
import 'package:http/http.dart' as http;
import '../user/model/User.dart';

class AttendanceService {
  final String baseUrl = 'http://localhost:8080/api/attendance';

  Future<List<Attendance>> getAllAttendances() async {
    final response = await http.get(Uri.parse('$baseUrl/'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Attendance.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load attendances');
    }
  }

  Future<Attendance> checkIn(int userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/checkin'),
      body: json.encode({'userId': userId}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return Attendance.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to check in');
    }
  }

  Future<Attendance> checkOut(int userId) async {
    final response = await http.put(
      Uri.parse('$baseUrl/checkout'),
      body: json.encode({'userId': userId}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return Attendance.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to check out');
    }
  }

  Future<List<Attendance>> getOvertimeByUser(int userId, DateTime startDate, DateTime endDate) async {
    final response = await http.get(
      Uri.parse('$baseUrl/overtime/$userId?startDate=${startDate.toIso8601String()}&endDate=${endDate.toIso8601String()}'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Attendance.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load overtime records');
    }
  }

  Future<List<Attendance>> getTodayAttendance() async {
    final response = await http.get(Uri.parse('$baseUrl/today'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Attendance.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load today’s attendance');
    }
  }

  Future<Attendance> findAttendanceById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/find/$id'));

    if (response.statusCode == 200) {
      return Attendance.fromJson(json.decode(response.body));
    } else {
      throw Exception('Attendance not found');
    }
  }

  Future<List<Attendance>> getAttendancesByUserId(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/user/$userId/attendances'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Attendance.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load user attendance records');
    }
  }

  Future<Map<String, dynamic>> getUsersWithAttendanceInRange(DateTime startDate, DateTime endDate) async {
    final response = await http.get(
      Uri.parse('$baseUrl/attendanceRange?startDate=${startDate.toIso8601String()}&endDate=${endDate.toIso8601String()}'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load attendance in range');
    }
  }

  Future<List<User>> getUsersWithoutAttendanceToday() async {
    final response = await http.get(Uri.parse('$baseUrl/usersWithoutAttendanceToday'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users without attendance today');
    }
  }

  Future<List<Object>> getPeakAttendanceDay() async {
    final response = await http.get(Uri.parse('$baseUrl/peakAttendanceDay'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load peak attendance day');
    }
  }

  Future<List<Object>> getPeakAttendanceMonth() async {
    final response = await http.get(Uri.parse('$baseUrl/peakAttendanceMonth'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load peak attendance month');
    }
  }

  Future<List<Attendance>> getLateCheckIns(String lateTime, DateTime startDate, DateTime endDate) async {
    final response = await http.get(
      Uri.parse('$baseUrl/lateCheckIns?lateTime=$lateTime&startDate=${startDate.toIso8601String()}&endDate=${endDate.toIso8601String()}'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Attendance.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load late check-ins');
    }
  }

  Future<List<Attendance>> getAttendancesByUserNamePart(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/searchByName?name=$name'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Attendance.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load attendances by user name');
    }
  }

  Future<List<Attendance>> getAttendanceByRole(String role) async {
    final response = await http.get(Uri.parse('$baseUrl/roleAttendance?role=$role'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Attendance.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load attendances by role');
    }
  }

  Future<List<Attendance>> getTodayAttendanceByUserId(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/todayAttendance/$userId'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Attendance.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load today’s attendance by user');
    }
  }
}

import 'dart:convert';
import 'package:hr_and_pms/features/leave/model/RequestStatus.dart';
import 'package:http/http.dart' as http;
import 'package:hr_and_pms/features/salary/model/Salary.dart';

class SalaryService {
  static const String baseUrl = 'http://localhost:8080/api/salaries';

  /// Create a new salary
  Future<Salary?> calculateAndSaveSalary(int userId) async {
    final url = Uri.parse('$baseUrl/calculate/$userId');
    try {
      final response = await http.post(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return Salary.fromJson(data);
      } else {
        throw Exception('Failed to calculate and save salary: ${response.body}');
      }
    } catch (e) {
      print('Error in calculateAndSaveSalary: $e');
      return null;
    }
  }

  Future<Salary?> getSalaryById(int id) async {
    final url = Uri.parse('$baseUrl/find/$id');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Salary.fromJson(data);
      } else {
        throw Exception('Failed to fetch salary by ID: ${response.body}');
      }
    } catch (e) {
      print('Error in getSalaryById: $e');
      return null;
    }
  }

  // Fetch all salaries
  Future<List<Salary>> getAllSalaries() async {
    final url = Uri.parse('$baseUrl/all');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Salary.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch all salaries: ${response.body}');
      }
    } catch (e) {
      print('Error in getAllSalaries: $e');
      return [];
    }
  }

  // Update salary
  Future<bool> updateSalary(int id, Salary salary) async {
    final url = Uri.parse('$baseUrl/update/$id');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(salary.toJson()),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error in updateSalary: $e');
      return false;
    }
  }

  // Delete salary by ID
  Future<bool> deleteSalary(int id) async {
    final url = Uri.parse('$baseUrl/delete/$id');
    try {
      final response = await http.delete(url);

      return response.statusCode == 204;
    } catch (e) {
      print('Error in deleteSalary: $e');
      return false;
    }
  }

  // Fetch salaries by status
  Future<List<Salary>> getSalariesByStatus(RequestStatus status) async {
    final url = Uri.parse('$baseUrl/status?status=${status.toShortString()}');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Salary.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch salaries by status: ${response.body}');
      }
    } catch (e) {
      print('Error in getSalariesByStatus: $e');
      return [];
    }
  }

  // Fetch salaries by user and date range
  Future<List<Salary>> getSalariesByUserAndDateRange(int userId, DateTime startDate, DateTime endDate) async {
    final url = Uri.parse('$baseUrl/user/$userId/range?startDate=${startDate.toIso8601String()}&endDate=${endDate.toIso8601String()}');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Salary.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch salaries by user and date range: ${response.body}');
      }
    } catch (e) {
      print('Error in getSalariesByUserAndDateRange: $e');
      return [];
    }
  }

  // Fetch salaries by date range
  Future<List<Salary>> getSalariesByDateRange(DateTime startDate, DateTime endDate) async {
    final url = Uri.parse('$baseUrl/date-range?startDate=${startDate.toIso8601String()}&endDate=${endDate.toIso8601String()}');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Salary.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch salaries by date range: ${response.body}');
      }
    } catch (e) {
      print('Error in getSalariesByDateRange: $e');
      return [];
    }
  }
}

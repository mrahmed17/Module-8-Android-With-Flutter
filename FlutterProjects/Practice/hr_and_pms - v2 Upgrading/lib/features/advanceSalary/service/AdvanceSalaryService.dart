import 'dart:convert';
import 'package:hr_and_pms/features/advanceSalary/model/AdvanceSalary.dart';
import 'package:http/http.dart' as http;

class AdvanceSalaryService {
  static const String baseUrl = 'http://localhost:8080/api/advanceSalaries'; // Replace with your backend API URL

  // Method to fetch all advance salaries for a user
  Future<List<AdvanceSalary>> getAdvanceSalaries() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => AdvanceSalary.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load advance salaries');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Method to get advance salary by ID
  Future<AdvanceSalary> getAdvanceSalaryById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/find/$id'));

      if (response.statusCode == 200) {
        return AdvanceSalary.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load advance salary');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Method to create a new advance salary
  Future<AdvanceSalary> createAdvanceSalary(AdvanceSalary advanceSalary) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/create'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(advanceSalary.toJson()),
      );

      if (response.statusCode == 200) {
        return AdvanceSalary.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create advance salary');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Method to update an existing advance salary
  Future<AdvanceSalary> updateAdvanceSalary(int id, AdvanceSalary advanceSalary) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/update/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(advanceSalary.toJson()),
      );

      if (response.statusCode == 200) {
        return AdvanceSalary.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update advance salary');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Method to delete an advance salary
  Future<void> deleteAdvanceSalary(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete advance salary');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Method to get advance salaries by date range
  Future<List<AdvanceSalary>> getAdvanceSalariesByDateRange(DateTime startDate, DateTime endDate) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/date-range?startDate=${startDate.toIso8601String()}&endDate=${endDate.toIso8601String()}'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => AdvanceSalary.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load advance salaries by date range');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Method to get the latest advance salary for a user
  Future<List<AdvanceSalary>> getLatestAdvanceSalaryByUser(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/latest/user/$userId'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => AdvanceSalary.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load latest advance salaries for user');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

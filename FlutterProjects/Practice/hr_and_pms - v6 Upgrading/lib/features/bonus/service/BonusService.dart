import 'dart:convert';
import 'package:hr_and_pms/features/bonus/model/Bonus.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class BonusService {
  static const String baseUrl = 'http://localhost:8080/api/bonuses';

  Future<Bonus?> createBonus(Bonus bonus) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/assign'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(bonus.toJson()),
      );
      if (response.statusCode == 200) {
        return Bonus.fromJson(json.decode(response.body));
      } else {
        print("Failed to create bonus: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error creating bonus: $e");
      return null;
    }
  }

  Future<Bonus?> updateBonus(int id, Bonus bonus) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/update/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(bonus.toJson()),
      );
      if (response.statusCode == 200) {
        return Bonus.fromJson(json.decode(response.body));
      } else {
        print("Failed to update bonus: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error updating bonus: $e");
      return null;
    }
  }

  // Method to delete a bonus
  Future<bool> deleteBonus(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));
      return response.statusCode == 200;
    } catch (e) {
      print("Error deleting bonus: $e");
      return false;
    }
  }

  // Method to get a bonus by ID
  Future<Bonus?> getBonusById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/find/$id'));

      if (response.statusCode == 200) {
        return Bonus.fromJson(json.decode(response.body));
      } else {
        print("Error fetching bonus by ID: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error fetching bonus by ID: $e");
      return null;
    }
  }

  Future<List<Bonus>> getBonusesByUser(int userId) async {
    return _fetchBonuses('$baseUrl/user/$userId');
  }

  // Method to get the total bonus for a user
  Future<double> getTotalBonusForUser(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/total/user/$userId'));

      if (response.statusCode == 200) {
        return double.parse(response.body);
      } else {
        return 0.0;
      }
    } catch (e) {
      print("Error fetching total bonus for user: $e");
      return 0.0;
    }
  }

  Future<List<Bonus>> getAllBonuses(int page, int size) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/allBonuses?page=$page&size=$size'),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((bonusJson) => Bonus.fromJson(bonusJson)).toList();
      } else {
        print("Error fetching bonuses: ${response.body}");
        return [];
      }
    } catch (e) {
      print("Error fetching bonuses: $e");
      return [];
    }
  }

  Future<List<Bonus>> getBonusesBetweenDates(DateTime startDate, DateTime endDate) async {
    try {
      final startDateStr = DateFormat('yyyy-MM-ddTHH:mm:ss').format(startDate);
      final endDateStr = DateFormat('yyyy-MM-ddTHH:mm:ss').format(endDate);
      return _fetchBonuses('$baseUrl/between?startDate=$startDateStr&endDate=$endDateStr');
    } catch (e) {
      print("Error formatting dates: $e");
      return [];
    }
  }

  // Method to get the total bonus for a specific month and year
  Future<double> getTotalBonusForMonth(int month, int year) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/monthly/$month/$year'),
      );

      if (response.statusCode == 200) {
        return double.parse(response.body);
      } else {
        return 0.0;
      }
    } catch (e) {
      print("Error fetching total bonus for month: $e");
      return 0.0;
    }
  }

  // Method to count bonuses for a user in a specific year
  Future<int> countBonusesForUserInYear(int userId, int year) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/count/user/$userId/year/$year'),
      );

      if (response.statusCode == 200) {
        return int.parse(response.body);
      } else {
        return 0;
      }
    } catch (e) {
      print("Error counting bonuses for user in year: $e");
      return 0;
    }
  }

  Future<List<Bonus>> getAllEmployees() async {
    return _fetchBonuses('$baseUrl/employees');
  }

  Future<List<Bonus>> _fetchBonuses(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((bonusJson) => Bonus.fromJson(bonusJson)).toList();
      } else {
        print("Failed to fetch data: ${response.reasonPhrase}");
        return [];
      }
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }
}

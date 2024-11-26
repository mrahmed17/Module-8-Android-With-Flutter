import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:hr_and_pms/administration/model/User.dart';

class AuthService {
  final String baseUrl = 'http://localhost:8080';

  // Register a user (admin, manager, employee)
  Future<bool> register(Map<String, dynamic> user, String role) async {
    try {
      final url = Uri.parse('$baseUrl/register/$role');
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode(user);

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String token = data['token'];

        // Save the token and role in SharedPreferences
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString('authToken', token);
        await preferences.setString('userRole', role);

        return true;
      } else {
        print('Registration failed: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final url = Uri.parse('$baseUrl/login');
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({'email': email, 'password': password});

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String token = data['token'];

        //Decode token to get role
        Map<String, dynamic> payload = Jwt.parseJwt(token);
        String role = payload['role'];

        //Store token and role
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString('authToken', token);
        await preferences.setString('userRole', role);

        // For getting login usr profile data
        // Line from Nusrat
        // await preferences.setString('user', jsonEncode(data['user']));

        return true;
      } else {
        print('Failed to login: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }


  Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('authToken');
    await preferences.remove('userRole');
  }

  Future<bool> isLoggedIn() async {
    String? token = await getToken();
    if (token != null && !(await isTokenExpired())) {
      return true;
    } else {
      await logout();
      return false;
    }
  }

  Future<bool> isTokenExpired() async {
    String? token = await getToken();
    if (token != null) {
      DateTime? expiryDate = Jwt.getExpiryDate(token);
      if (expiryDate != null) {
        return DateTime.now().isAfter(expiryDate);
      } else {
        return true;
      }
    }
    return true;
  }

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('authToken');
  }

  // Future<Map<String, dynamic>?> getUser() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? userJson = prefs.getString('user');
  //
  //   if (userJson != null) {
  //     return jsonDecode(userJson);
  //   } else {
  //     return null;
  //   }
  // }

  Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    User? user = User.fromJson(jsonDecode(userJson!));
    return user;
    }

  Future<String?> getUserRole() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(preferences.getString('userRole'));
    return preferences.getString('userRole');
  }

  Future<bool> forgotPassword(String email) async {
    final url = Uri.parse('$baseUrl/forgot-password');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': email});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return true; // Reset link sent successfully
      } else {
        print('Failed to send reset link: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> hasRole(List<String> roles) async {
    String? role = await getUserRole();
    return role != null && roles.contains(role);
  }

  Future<bool> isAdmin() async {
    return await hasRole(['ADMIN']);
  }

  Future<bool> isManager() async {
    return await hasRole(['MANAGER']);
  }

  Future<bool> isEmployee() async {
    return await hasRole(['EMPLOYEE']);
  }
}

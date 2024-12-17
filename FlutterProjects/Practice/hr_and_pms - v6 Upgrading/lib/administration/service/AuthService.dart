import 'dart:convert';
import 'dart:io';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:hr_and_pms/administration/model/User.dart';

class AuthService {
  final String baseUrl = 'http://localhost:8080';

  // Generic registration method with multipart support
  Future<http.Response> registerUser({
    required Map<String, dynamic> userData,
    required String role,
    XFile? mobilePhoto,
    Uint8List? webPhoto,
  }) async {
    try {
      // Build URL dynamically based on role
      final String url = "$baseUrl/register/${role.toLowerCase()}";
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Add JSON user data as a multipart field
      request.files.add(
        http.MultipartFile.fromString(
          'user',
          jsonEncode(userData),
          contentType: MediaType('application', 'json'),
        ),
      );

      // Add profile photo (if provided)
      if (webPhoto != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'profilePhoto',
            webPhoto,
            filename: 'upload.jpg',
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      } else if (mobilePhoto != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'profilePhoto',
            mobilePhoto.path,
          ),
        );
      }

      // Send request
      final response = await request.send();
      return await http.Response.fromStream(response);
    } catch (e) {
      debugPrint("Error during registration: $e");
      rethrow;
    }
  }

  // Register a user (admin, manager, employee)
  // Future<bool> register(Map<String, dynamic> user, String role) async {
  //   try {
  //     final url = Uri.parse('$baseUrl/register/$role');
  //     final headers = {'Content-Type': 'application/json'};
  //     final body = jsonEncode(user);
  //
  //     final response = await http.post(url, headers: headers, body: body);
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       String token = data['token'];
  //
  //       // Save the token and role in SharedPreferences
  //       SharedPreferences preferences = await SharedPreferences.getInstance();
  //       await preferences.setString('authToken', token);
  //       await preferences.setString('userRole', role);
  //
  //       return true;
  //     } else {
  //       print('Registration failed: ${response.body}');
  //       return false;
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     return false;
  //   }
  // }

  Future<bool> login(String email, String password) async {
    try {
      final url = Uri.parse('$baseUrl/login');
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({'email': email, 'password': password});

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String token = data['token'];
        Map<String, dynamic> user = data['user'];

        //Decode token to get role
        Map<String, dynamic> payload = Jwt.parseJwt(token);
        String role = payload['role'];

        //Store token and role
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString('authToken', token);
        await preferences.setString('userRole', role);
        await preferences.setString('user', jsonEncode(user));

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
    try {
      String? token = await getToken();
      if (token != null) {
        final url = Uri.parse('$baseUrl/logout');
        final headers = {'Content-Type': 'application/json'};
        final body = jsonEncode({'token': token});

        await http.post(url, headers: headers, body: body);
      }

      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  // Future<void> logout() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   await preferences.remove('authToken');
  //   await preferences.remove('userRole');
  // }

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

  /// Get User Profile
  Future<User?> getUserProfile(String email) async {
    try {
      final url = Uri.parse('$baseUrl/profile?email=$email');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        print('Failed to fetch profile: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error fetching profile: $e');
      return null;
    }
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

    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson)); // Convert JSON to User object
    } else {
      return null;
    }
  }

  Future<String?> getUserRole() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(preferences.getString('userRole'));
    return preferences.getString('userRole');
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

  /// Forgot Password
  Future<bool> forgotPassword(String email) async {
    try {
      final url = Uri.parse('$baseUrl/forgot-password');
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({'email': email});

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return true; // Reset link sent successfully
      } else {
        print('Failed to send reset link: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error during forgot password: $e');
      return false;
    }
  }

  /// Reset Password
  Future<bool> resetPassword(String token, String newPassword) async {
    try {
      final url = Uri.parse('$baseUrl/reset-password');
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({'token': token, 'newPassword': newPassword});

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to reset password: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error during reset password: $e');
      return false;
    }
  }

}

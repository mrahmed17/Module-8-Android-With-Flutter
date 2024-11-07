import 'dart:convert';
import 'package:hr_and_payroll_management/features/user/models/Role.dart';
import 'package:hr_and_payroll_management/features/user/models/User.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = 'http://localhost:8080/api/users';

  // Create a new user

  Future<String> createUser(User user, String? profilePhotoPath) async {
    var uri = Uri.parse('$baseUrl/create');
    var request = http.MultipartRequest('POST', uri);

    // Attach user data as JSON
    request.fields['user'] = jsonEncode(user.toJson());

    // Attach profile photo if provided
    if (profilePhotoPath != null) {
      request.files.add(await http.MultipartFile.fromPath('profilePhoto', profilePhotoPath));
    }

    var response = await request.send();
    if (response.statusCode == 201) {
      return 'User created successfully.';
    } else {
      return 'Failed to create user: ${response.reasonPhrase}';
    }
  }

  // Future<void> createUser(User user) async {
  //   final response = await http.post(
  //     Uri.parse('http://localhost:8080/users'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //     },
  //     body: jsonEncode(user.toJson()),
  //   );
  //   // Handle response
  // }

  // Update an existing user
  Future<String> updateUser(int id, User user, String? profilePhotoPath) async {
    var uri = Uri.parse('$baseUrl/update/$id');
    var request = http.MultipartRequest('PUT', uri);

    request.fields['user'] = jsonEncode(user.toJson());

    if (profilePhotoPath != null) {
      request.files.add(await http.MultipartFile.fromPath('profilePhoto', profilePhotoPath));
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      return 'User updated successfully.';
    } else {
      return 'Failed to update user: ${response.reasonPhrase}';
    }
  }

  // Get all users
  Future<List<User>> getAllUsers() async {
    var response = await http.get(Uri.parse('$baseUrl/all'));
    if (response.statusCode == 200) {
      List<dynamic> usersJson = jsonDecode(response.body);
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  // Find user by ID
  Future<User?> findUserById(int id) async {
    var response = await http.get(Uri.parse('$baseUrl/find/$id'));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  // Delete user
  Future<String> deleteUser(int id) async {
    var response = await http.delete(Uri.parse('$baseUrl/delete/$id'));
    if (response.statusCode == 200) {
      return 'User deleted successfully.';
    } else {
      return 'Failed to delete user: ${response.reasonPhrase}';
    }
  }

  // Find user by email
  Future<User?> getUserByEmail(String email) async {
    var response = await http.get(Uri.parse('$baseUrl/email/$email'));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  // Get users with salary greater than or equal
  Future<List<User>> getUsersWithSalaryGreaterThanOrEqual(double salary, {int page = 0, int size = 10}) async {
    var uri = Uri.parse('$baseUrl/salary/greaterThanOrEqual?salary=$salary&page=$page&size=$size');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> usersJson = jsonDecode(response.body)['content'];
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users with salary >= $salary');
    }
  }

  // Get users with salary less than or equal
  Future<List<User>> getUsersWithSalaryLessThanOrEqual(double salary, {int page = 0, int size = 10}) async {
    var uri = Uri.parse('$baseUrl/salary/lessThanOrEqual?salary=$salary&page=$page&size=$size');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> usersJson = jsonDecode(response.body)['content'];
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users with salary <= $salary');
    }
  }

  // Get users by role
  Future<List<User>> getUsersByRole(Role role, {int page = 0, int size = 10}) async {
    var uri = Uri.parse('$baseUrl/role/${role.name}?page=$page&size=$size');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> usersJson = jsonDecode(response.body)['content'];
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users by role');
    }
  }

  // Search users by name
  Future<List<User>> searchUsersByName(String name, {int page = 0, int size = 10}) async {
    var uri = Uri.parse('$baseUrl/search/name/$name?page=$page&size=$size');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> usersJson = jsonDecode(response.body)['content'];
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search users by name');
    }
  }

  // Search users by gender
  Future<List<User>> getUsersByGender(String gender, {int page = 0, int size = 10}) async {
    var uri = Uri.parse('$baseUrl/gender/$gender?page=$page&size=$size');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> usersJson = jsonDecode(response.body)['content'];
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users by gender');
    }
  }

  // Search users by joined date
  Future<List<User>> getUsersByJoinedDate(String joinedDate, {int page = 0, int size = 10}) async {
    var uri = Uri.parse('$baseUrl/joinedDate/$joinedDate?page=$page&size=$size');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> usersJson = jsonDecode(response.body)['content'];
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users by joined date');
    }
  }
}
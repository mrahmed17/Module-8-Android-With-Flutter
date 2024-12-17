import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hr_and_pms/administration/model/User.dart';

class UserService {
  final Dio _dio = Dio();
  final String baseUrl = 'http://localhost:8080/api/users';

  // Update user profile with optional profile photo
  Future<String> updateUserProfile(
      int id, User user, XFile? profilePhoto) async {
    try {
      final formData = await _prepareUserDataForm(user, profilePhoto);
      final response = await _dio.put(
        '$baseUrl/update/$id',
        data: formData,
      );

      return response.statusCode == 200
          ? 'User updated successfully.'
          : 'Failed to update user: ${response.statusMessage}';
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // Prepare form data for user update
  Future<FormData> _prepareUserDataForm(User user, XFile? profilePhoto) async {
    final formData = FormData();
    formData.fields.add(MapEntry('user', jsonEncode(user.toJson())));

    if (profilePhoto != null) {
      final bytes = await profilePhoto.readAsBytes();
      formData.files.add(
        MapEntry(
          'profilePhoto',
          MultipartFile.fromBytes(bytes, filename: profilePhoto.name),
        ),
      );
    }
    return formData;
  }

  // Get user by ID
  Future<User?> findUserById(int id) async {
    try {
      final response = await _dio.get('$baseUrl/find/$id');
      return response.statusCode == 200 ? User.fromJson(response.data) : null;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // Get all managers
  Future<List<User>> getAllManagers() async {
    try {
      final response = await _dio.get('$baseUrl/getAllManagers');
      return (response.data as List).map((userJson) => User.fromJson(userJson)).toList();
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // Get all employees
  Future<List<User>> getAllEmployees() async {
    try {
      final response = await _dio.get('$baseUrl/getAllEmployees');
      return (response.data as List).map((userJson) => User.fromJson(userJson)).toList();
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // Filter by name and gender
  Future<List<User>> filtersByNameGender(String name, String gender) async {
    try {
      final response = await _dio.get(
        '$baseUrl/filtersByNameGender',
        queryParameters: {'name': name, 'gender': gender},
      );
      return (response.data as List).map((userJson) => User.fromJson(userJson)).toList();
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // Get users by joined date
  Future<List<User>> getUsersByJoinedDate(String joinedDate) async {
    try {
      final response = await _dio.get(
        '$baseUrl/getUsersByJoinedDate',
        queryParameters: {'joinedDate': joinedDate},
      );
      return (response.data as List).map((userJson) => User.fromJson(userJson)).toList();
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // Get users with salary >= specified amount
  Future<List<User>> getUsersWithSalaryGreaterThanOrEqual(double salary) async {
    try {
      final response = await _dio.get(
        '$baseUrl/salary/greaterThanOrEqual',
        queryParameters: {'salary': salary},
      );
      return (response.data as List).map((userJson) => User.fromJson(userJson)).toList();
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // Get users with salary <= specified amount
  Future<List<User>> getUsersWithSalaryLessThanOrEqual(double salary) async {
    try {
      final response = await _dio.get(
        '$baseUrl/salary/lessThanOrEqual',
        queryParameters: {'salary': salary},
      );
      return (response.data as List).map((userJson) => User.fromJson(userJson)).toList();
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // Helper method to handle errors from Dio
  String _handleError(DioException e) {
    return e.response?.data?['message'] ?? 'Error: ${e.message}';
  }
}

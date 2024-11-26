import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hr_and_pms/administration/model/User.dart';

class UserService {
  final Dio _dio = Dio();
  final String baseUrl = 'http://localhost:8080/api/auth';

  // Get user by ID
  Future<User?> getUserById(int id) async {
    try {
      final response = await _dio.get('$baseUrl/find/$id');
      return response.statusCode == 200 ? User.fromJson(response.data) : null;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // Update user profile with optional profile photo
  Future<String> updateUser(int id, User user, XFile? profilePhoto) async {
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

  // Helper method to prepare user data with profile photo if available
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

  // Fetch managers with pagination
  Future<List<User>> getAllManagers(int page, int size) async {
    return _fetchUsersByEndpoint('getAllManagers', page, size);
  }

  // Fetch employees with pagination
  Future<List<User>> getAllEmployees(int page, int size) async {
    return _fetchUsersByEndpoint('getAllEmployees', page, size);
  }

  Future<List<User>> searchUsersByName(String name, {int page = 0, int size = 10}) async {
    try {
      final response = await _dio.get(
        '$baseUrl/searchUsersByName',
        queryParameters: {'page': page, 'size': size},
      );
      return (response.data['content'] as List)
          .map((userJson) => User.fromJson(userJson))
          .toList();
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<List<User>> getUsersByGender(String gender, {int page = 0, int size = 10}) async {
    try {
      final response = await _dio.get(
        '$baseUrl/gender/$gender',
        queryParameters: {'page': page, 'size': size},
      );
      return (response.data['content'] as List)
          .map((userJson) => User.fromJson(userJson))
          .toList();
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // Filtered user search methods
  Future<List<User>> getUsersWithSalaryGreaterThanOrEqual(double salary, {int page = 0, int size = 10}) async {
    try {
      final response = await _dio.get(
        '$baseUrl/salary/greaterThanOrEqual',
        queryParameters: {'salary': salary, 'page': page, 'size': size},
      );
      return (response.data['content'] as List)
          .map((userJson) => User.fromJson(userJson))
          .toList();
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<List<User>> getUsersWithSalaryLessThanOrEqual(double salary, {int page = 0, int size = 10}) async {
    try {
      final response = await _dio.get(
        '$baseUrl/salary/lessThanOrEqual',
        queryParameters: {'salary': salary, 'page': page, 'size': size},
      );
      return (response.data['content'] as List)
          .map((userJson) => User.fromJson(userJson))
          .toList();
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<List<User>> getUsersByJoinedDate(String joinedDate, {int page = 0, int size = 10}) async {
    try {
      final response = await _dio.get(
        '$baseUrl/joinedDate/$joinedDate',
        queryParameters: {'page': page, 'size': size},
      );
      return (response.data['content'] as List)
          .map((userJson) => User.fromJson(userJson))
          .toList();
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // Generic method to handle paginated user data fetching
  Future<List<User>> _fetchUsersByEndpoint(String endpoint, int page, int size) async {
    try {
      final response = await _dio.get(
        '$baseUrl/$endpoint',
        queryParameters: {'page': page, 'size': size},
      );
      return (response.data['content'] as List)
          .map((userJson) => User.fromJson(userJson))
          .toList();
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // Helper method to handle errors from Dio
  String _handleError(DioException e) {
    return e.response?.data?['message'] ?? 'Error: ${e.message}';
  }

}

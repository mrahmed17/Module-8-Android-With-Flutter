// utils/api_client.dart
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  ApiClient() {
    _dio.options.baseUrl = "http://localhost:8080/api"; // Replace with your backend URL
    _dio.options.headers["Content-Type"] = "application/json";
  }

  Future<String?> getAuthToken() async {
    return await _storage.read(key: "authToken");
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    String? token = await getAuthToken();
    if (token != null) _dio.options.headers["Authorization"] = "Bearer $token";
    return await _dio.get(endpoint, queryParameters: queryParameters);
  }

  Future<Response> post(String endpoint, dynamic data) async {
    String? token = await getAuthToken();
    if (token != null) _dio.options.headers["Authorization"] = "Bearer $token";
    return await _dio.post(endpoint, data: data);
  }

  Future<Response> put(String endpoint, dynamic data) async {
    String? token = await getAuthToken();
    if (token != null) _dio.options.headers["Authorization"] = "Bearer $token";
    return await _dio.put(endpoint, data: data);
  }

  Future<Response> delete(String endpoint) async {
    String? token = await getAuthToken();
    if (token != null) _dio.options.headers["Authorization"] = "Bearer $token";
    return await _dio.delete(endpoint);
  }
}

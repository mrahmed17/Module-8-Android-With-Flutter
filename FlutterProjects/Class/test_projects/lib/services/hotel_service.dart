import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_projects/models/hotel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:test_projects/services/AuthService.dart';

class HotelService {
  final Dio _dio = Dio();

  final AuthService authService = AuthService();

  final String apiUrl =
      'http://localhost:8080/api/hotel/'; // Spring boot api URL

  Future<List<Hotel>> fetchHotels() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> hotelJson = json.decode(response.body);

      return hotelJson.map((json) => Hotel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load hotels');
    }
  }

  Future<Hotel?> createHotel(Hotel hotel, XFile? image) async {
    final formData = FormData();
    formData.fields.add(MapEntry('hotel', jsonEncode(hotel.toJson())));

    if (image != null) {
      final bytes = await image.readAsBytes();
      formData.files.add(MapEntry(
          'image',
          MultipartFile.fromBytes(
            bytes,
            filename: image.name,
          )));
    }

    final token = await authService.getToken();
    final headers = {'Authorization': 'Bearer $token'};

    try {
      final response = await _dio.post(
        '${apiUrl}save',
        data: formData,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return Hotel.fromJson(data); // Parse response data to hotel objects
      } else {
        print('Error creating hotel: ${response.statusCode}');
        return null;
      }
    } on DioError catch (e) {
      print('Error creating hotel: ${e.message}');
      return null;
    }
  }
}

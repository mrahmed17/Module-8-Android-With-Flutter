import 'package:test_projects/models/hotel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HotelService {
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
}

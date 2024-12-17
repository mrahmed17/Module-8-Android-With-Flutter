import 'dart:convert';
import 'package:http/http.dart' as http;

class PaySlipService {
  final String baseUrl = 'http://localhost:8080/api/payslips';


  Future<Map<String, dynamic>> fetchPayslipData(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/user/$userId/payslip-data'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load payslip data');
    }
  }


}

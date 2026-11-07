import 'dart:convert';

import 'package:http/http.dart' as http;

class PredictionService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  static Future<Map<String, dynamic>> predictChurn(
    Map<String, dynamic> customerData,
  ) async {
    final uri = Uri.parse('$baseUrl/predict');

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(customerData),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(responseData);
      }

      final errorMessage = responseData is Map
          ? responseData['detail']?.toString() ?? 'Prediction failed.'
          : 'Prediction failed.';

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Unable to get prediction: $e');
    }
  }
}
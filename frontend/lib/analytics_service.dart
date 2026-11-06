import 'dart:convert';

import 'package:http/http.dart' as http;

class AnalyticsService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  static Future<List<Map<String, dynamic>>> fetchContractAnalytics() async {
    final uri = Uri.parse('$baseUrl/analytics/contracts');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        final List<dynamic> analytics = data['contract_analytics'];

        return analytics
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
      } else {
        throw Exception(
          'Failed to load contract analytics: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Unable to fetch contract analytics: $e');
    }
  }
}
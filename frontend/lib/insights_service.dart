import 'dart:convert';

import 'package:http/http.dart' as http;
import 'app_config.dart';

class InsightsService {
  static const String baseUrl = AppConfig.apiBaseUrl;

  static Future<List<Map<String, dynamic>>> fetchInsights() async {
    final uri = Uri.parse('$baseUrl/analytics/retention-insights');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        final List<dynamic> insights = data['retention_insights'];

        return insights
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
      }

      throw Exception(
        'Failed to load retention insights: ${response.statusCode}',
      );
    } catch (e) {
      throw Exception('Unable to fetch retention insights: $e');
    }
  }
}
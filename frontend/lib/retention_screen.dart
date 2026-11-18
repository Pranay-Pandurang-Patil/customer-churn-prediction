import 'package:flutter/material.dart';
import 'insights_service.dart';

class RetentionScreen extends StatefulWidget {
  const RetentionScreen({super.key});

  @override
  State<RetentionScreen> createState() => _RetentionScreenState();
}

class _RetentionScreenState extends State<RetentionScreen> {
  late Future<List<Map<String, dynamic>>> insightsFuture;

  @override
  void initState() {
    super.initState();
    insightsFuture = InsightsService.fetchInsights();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Retention Insights',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Discover customer segments with higher churn risk '
            'and identify retention opportunities.',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 30),

          FutureBuilder<List<Map<String, dynamic>>>(
            future: insightsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(50),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (snapshot.hasError) {
                return _statusCard(
                  Icons.cloud_off_outlined,
                  'Unable to load retention insights',
                  'Check the backend connection.',
                );
              }

              final insights = snapshot.data ?? [];

              if (insights.isEmpty) {
                return _statusCard(
                  Icons.analytics_outlined,
                  'No insights available',
                  'The API returned no analytics data.',
                );
              }

              final dimensions = <String, List<Map<String, dynamic>>>{};

              for (final item in insights) {
                final dimension =
                    item['dimension']?.toString() ?? 'Other';

                dimensions.putIfAbsent(dimension, () => []);
                dimensions[dimension]!.add(item);
              }

              return Column(
                children: dimensions.entries.map((entry) {
                  return _insightSection(
                    entry.key,
                    entry.value,
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _insightSection(
    String title,
    List<Map<String, dynamic>> items,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF312E81),
            ),
          ),

          const SizedBox(height: 22),

          ...items.map((item) {
            return _segmentCard(item);
          }),
        ],
      ),
    );
  }

  Widget _segmentCard(Map<String, dynamic> item) {
    final segment = item['segment']?.toString() ?? 'Unknown';

    final total = (item['total_customers'] as num?)?.toInt() ?? 0;

    final churned =
        (item['churned_customers'] as num?)?.toInt() ?? 0;

    final rate =
        (item['churn_rate'] as num?)?.toDouble() ?? 0.0;

    final progress = (rate / 100).clamp(0.0, 1.0).toDouble();

    final Color riskColor = rate >= 50
        ? const Color(0xFFDC2626)
        : rate >= 25
            ? const Color(0xFFF59E0B)
            : const Color(0xFF059669);

    final String riskLabel = rate >= 50
        ? 'High churn'
        : rate >= 25
            ? 'Moderate churn'
            : 'Lower churn';

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  segment,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Text(
                '${rate.toStringAsFixed(2)}%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: riskColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 11,
              backgroundColor: const Color(0xFFE5E7EB),
              color: riskColor,
            ),
          ),

          const SizedBox(height: 9),

          Row(
            children: [
              Expanded(
                child: Text(
                  'Customers: $total',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.blueGrey,
                  ),
                ),
              ),

              Text(
                'Churned: $churned',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Text(
            riskLabel,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: riskColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusCard(
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 38,
            color: Colors.blueGrey,
          ),

          const SizedBox(height: 14),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            description,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
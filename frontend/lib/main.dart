import 'package:flutter/material.dart';

void main() {
  runApp(const ChurnAnalyticsApp());
}

class ChurnAnalyticsApp extends StatelessWidget {
  const ChurnAnalyticsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer Churn Analytics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        fontFamily: 'Arial',
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // SIDEBAR
          Container(
            width: 240,
            color: const Color(0xFF1E1B4B),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'ChurnAnalytics',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _sidebarItem(
                  Icons.dashboard_rounded,
                  'Dashboard',
                  true,
                ),
                _sidebarItem(
                  Icons.analytics_outlined,
                  'Churn Analytics',
                  false,
                ),
                _sidebarItem(
                  Icons.psychology_outlined,
                  'Predict Churn',
                  false,
                ),
                _sidebarItem(
                  Icons.lightbulb_outline,
                  'Retention Insights',
                  false,
                ),
                _sidebarItem(
                  Icons.info_outline,
                  'About Model',
                  false,
                ),
              ],
            ),
          ),

          // MAIN DASHBOARD
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // DASHBOARD HEADER
                  const Text(
                    'Customer Churn Dashboard',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Monitor churn patterns and predict customer risk.',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // OVERVIEW SECTION
                  const Text(
                    'Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // KPI CARDS
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      _metricCard(
                        'Total Customers',
                        '7,043',
                        Icons.people_alt_outlined,
                      ),
                      _metricCard(
                        'Churned Customers',
                        '1,869',
                        Icons.person_remove_outlined,
                      ),
                      _metricCard(
                        'Retained Customers',
                        '5,174',
                        Icons.people_outline,
                      ),
                      _metricCard(
                        'Churn Rate',
                        '26.5%',
                        Icons.trending_up,
                      ),
                      _metricCard(
                        'Model ROC-AUC',
                        '84.14%',
                        Icons.insights,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // REUSABLE KPI CARD
  static Widget _metricCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      width: 210,
      padding: const EdgeInsets.all(20),
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
          Icon(
            icon,
            color: const Color(0xFF4F46E5),
            size: 26,
          ),

          const SizedBox(height: 16),

          Text(
            title,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // SIDEBAR NAVIGATION ITEM
  static Widget _sidebarItem(
    IconData icon,
    String title,
    bool selected,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: selected
            ? const Color(0xFF4F46E5)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        dense: true,
      ),
    );
  }
}
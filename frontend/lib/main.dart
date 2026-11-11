import 'package:flutter/material.dart';
import 'analytics_service.dart';
import 'prediction_screen.dart';

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

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  final List<String> pageTitles = [
    'Dashboard',
    'Churn Analytics',
    'Predict Churn',
    'Retention Insights',
    'About Model',
  ];

  Widget _getSelectedPage() {
    switch (selectedIndex) {
      case 0:
      case 1:
        return _buildDashboardContent();

      case 2:
        return const PredictionScreen();

      default:
        return Center(
          child: Text(
            '${pageTitles[selectedIndex]} - Coming Soon',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
    }
  }

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
                  0,
                ),

                _sidebarItem(
                  Icons.analytics_outlined,
                  'Churn Analytics',
                  1,
                ),

                _sidebarItem(
                  Icons.psychology_outlined,
                  'Predict Churn',
                  2,
                ),

                _sidebarItem(
                  Icons.lightbulb_outline,
                  'Retention Insights',
                  3,
                ),

                _sidebarItem(
                  Icons.info_outline,
                  'About Model',
                  4,
                ),
              ],
            ),
          ),

          // MAIN CONTENT
          Expanded(
            child: _getSelectedPage(),
          ),
        ],
      ),
    );
  }

  // SIDEBAR NAVIGATION
  Widget _sidebarItem(
    IconData icon,
    String title,
    int index,
  ) {
    final bool selected = selectedIndex == index;

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
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }

  // DASHBOARD CONTENT
  Widget _buildDashboardContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

          const SizedBox(height: 36),

          const Text(
            'Churn Analytics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          _distributionCard(),

          const SizedBox(height: 36),

          const Text(
            'Contract-wise Churn Analysis',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Analyze customer churn across different contract types.',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 20),

          const ContractAnalyticsCard(),
        ],
      ),
    );
  }

  // KPI CARD
  Widget _metricCard(
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

  // CUSTOMER DISTRIBUTION CARD
  Widget _distributionCard() {
    return Container(
      width: 500,
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
          const Text(
            'Customer Churn Distribution',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 24),

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const Row(
              children: [
                Expanded(
                  flex: 5174,
                  child: SizedBox(
                    height: 18,
                    child: ColoredBox(
                      color: Color(0xFF4F46E5),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1869,
                  child: SizedBox(
                    height: 18,
                    child: ColoredBox(
                      color: Color(0xFFF59E0B),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          _legendItem(
            const Color(0xFF4F46E5),
            'Retained Customers',
            '5,174 (73.5%)',
          ),

          const SizedBox(height: 14),

          _legendItem(
            const Color(0xFFF59E0B),
            'Churned Customers',
            '1,869 (26.5%)',
          ),
        ],
      ),
    );
  }

  // CHART LEGEND
  Widget _legendItem(
    Color color,
    String title,
    String value,
  ) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ),

        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

// CONTRACT ANALYTICS CARD
class ContractAnalyticsCard extends StatefulWidget {
  const ContractAnalyticsCard({super.key});

  @override
  State<ContractAnalyticsCard> createState() =>
      _ContractAnalyticsCardState();
}

class _ContractAnalyticsCardState
    extends State<ContractAnalyticsCard> {
  late Future<List<Map<String, dynamic>>> analyticsFuture;

  @override
  void initState() {
    super.initState();
    analyticsFuture = AnalyticsService.fetchContractAnalytics();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: analyticsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return _statusCard(
            icon: Icons.cloud_off_outlined,
            message: 'Unable to load contract analytics.',
            description: 'Check the backend connection.',
          );
        }

        final analytics = snapshot.data ?? [];

        if (analytics.isEmpty) {
          return _statusCard(
            icon: Icons.analytics_outlined,
            message: 'No analytics data available.',
            description: 'The API returned an empty result.',
          );
        }

        return Container(
          width: double.infinity,
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
              const Text(
                'Churn Rate by Contract',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              ...analytics.map((item) {
                final contract =
                    item['Contract']?.toString() ?? 'Unknown';

                final totalCustomers =
                    (item['total_customers'] as num?)?.toInt() ?? 0;

                final churnedCustomers =
                    (item['churned_customers'] as num?)?.toInt() ?? 0;

                final churnRate =
                    (item['churn_rate'] as num?)?.toDouble() ?? 0.0;

                return _contractItem(
                  contract: contract,
                  totalCustomers: totalCustomers,
                  churnedCustomers: churnedCustomers,
                  churnRate: churnRate,
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _contractItem({
    required String contract,
    required int totalCustomers,
    required int churnedCustomers,
    required double churnRate,
  }) {
    final normalizedRate =
        (churnRate / 100).clamp(0.0, 1.0).toDouble();

    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  contract,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Text(
                '${churnRate.toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFDC2626),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: normalizedRate,
              minHeight: 12,
              backgroundColor: const Color(0xFFE5E7EB),
              color: const Color(0xFFEF4444),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            'Customers: $totalCustomers  |  Churned: $churnedCustomers',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusCard({
    required IconData icon,
    required String message,
    required String description,
  }) {
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
            size: 36,
            color: Colors.blueGrey,
          ),

          const SizedBox(height: 12),

          Text(
            message,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 6),

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
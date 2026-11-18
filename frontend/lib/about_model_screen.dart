import 'package:flutter/material.dart';

class AboutModelScreen extends StatelessWidget {
  const AboutModelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About the Model',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Understand the machine learning model powering '
            'customer churn predictions.',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 30),

          _sectionCard(
            title: 'Selected Algorithm',
            icon: Icons.psychology,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Logistic Regression',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4F46E5),
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Logistic Regression was selected after comparing '
                  'multiple machine learning algorithms. It estimates '
                  'the probability of customer churn using customer '
                  'account, service and billing information.',
                  style: TextStyle(
                    height: 1.6,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          _sectionCard(
            title: 'Model Performance',
            icon: Icons.analytics_outlined,
            child: Column(
              children: [
                _metricRow('Accuracy', '73.74%'),
                _metricRow('Precision', '50.34%'),
                _metricRow('Recall', '78.34%'),
                _metricRow('F1-Score', '61.30%'),
                _metricRow('ROC-AUC', '84.14%'),
              ],
            ),
          ),

          const SizedBox(height: 24),

          _sectionCard(
            title: 'Dataset Information',
            icon: Icons.storage_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoRow('Dataset', 'IBM Telco Customer Churn'),
                _infoRow('Total Records', '7,043'),
                _infoRow('Total Columns', '21'),
                _infoRow('Input Features', '19'),
                _infoRow('Target Variable', 'Churn'),
              ],
            ),
          ),

          const SizedBox(height: 24),

          _sectionCard(
            title: 'Data Preprocessing',
            icon: Icons.tune,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bulletPoint(
                  'Numerical missing values handled using median imputation.',
                ),
                _bulletPoint(
                  'Categorical missing values handled using most-frequent imputation.',
                ),
                _bulletPoint(
                  'Numerical features standardized using StandardScaler.',
                ),
                _bulletPoint(
                  'Categorical features encoded using OneHotEncoder.',
                ),
                _bulletPoint(
                  'Unknown categorical values handled using handle_unknown="ignore".',
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          _sectionCard(
            title: 'Machine Learning Pipeline',
            icon: Icons.account_tree_outlined,
            child: const Column(
              children: [
                _pipelineStep('1', 'Customer Input'),
                _pipelineStep('2', 'Data Preprocessing'),
                _pipelineStep('3', 'Logistic Regression'),
                _pipelineStep('4', 'Churn Probability'),
                _pipelineStep('5', 'Prediction Result'),
              ],
            ),
          ),

          const SizedBox(height: 24),

          _sectionCard(
            title: 'Technology Stack',
            icon: Icons.code,
            child: const Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _technologyChip('Python'),
                _technologyChip('Pandas'),
                _technologyChip('NumPy'),
                _technologyChip('Scikit-learn'),
                _technologyChip('Joblib'),
                _technologyChip('FastAPI'),
                _technologyChip('Flutter'),
                _technologyChip('Dart'),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              'Note: Model predictions are estimates based on '
              'historical customer data. They should support, '
              'not replace, business decision-making.',
              style: TextStyle(
                color: Color(0xFF3730A3),
                height: 1.5,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _sectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
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
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF4F46E5),
              ),

              const SizedBox(width: 12),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          child,
        ],
      ),
    );
  }

  static Widget _metricRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 14,
              ),
            ),
          ),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 14,
              ),
            ),
          ),

          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _bulletPoint extends StatelessWidget {
  final String text;

  const _bulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFF059669),
            size: 18,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                height: 1.5,
                color: Colors.blueGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _pipelineStep extends StatelessWidget {
  final String number;
  final String title;

  const _pipelineStep(this.number, this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: const Color(0xFF4F46E5),
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 14),

          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _technologyChip extends StatelessWidget {
  final String title;

  const _technologyChip(this.title);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(title),
      backgroundColor: const Color(0xFFEEF2FF),
      side: BorderSide.none,
      labelStyle: const TextStyle(
        color: Color(0xFF3730A3),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
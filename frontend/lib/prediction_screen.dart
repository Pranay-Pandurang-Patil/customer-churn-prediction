import 'package:flutter/material.dart';
import 'prediction_service.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController tenureController =
      TextEditingController();

  final TextEditingController monthlyChargesController =
      TextEditingController();

  final TextEditingController totalChargesController =
      TextEditingController();

  final Map<String, String> customerData = {
    'gender': 'Male',
    'SeniorCitizen': '0',
    'Partner': 'No',
    'Dependents': 'No',
    'PhoneService': 'Yes',
    'MultipleLines': 'No',
    'InternetService': 'DSL',
    'OnlineSecurity': 'No',
    'OnlineBackup': 'No',
    'DeviceProtection': 'No',
    'TechSupport': 'No',
    'StreamingTV': 'No',
    'StreamingMovies': 'No',
    'Contract': 'Month-to-month',
    'PaperlessBilling': 'Yes',
    'PaymentMethod': 'Electronic check',
  };

  bool isLoading = false;

  Map<String, dynamic>? predictionResult;

  String? errorMessage;

  @override
  void dispose() {
    tenureController.dispose();
    monthlyChargesController.dispose();
    totalChargesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Predict Customer Churn',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Enter customer information to estimate churn risk.',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 30),

            _sectionTitle('Personal Information'),

            _dropdown(
              'Gender',
              'gender',
              ['Male', 'Female'],
            ),

            _dropdown(
              'Senior Citizen',
              'SeniorCitizen',
              ['0', '1'],
            ),

            _dropdown(
              'Partner',
              'Partner',
              ['Yes', 'No'],
            ),

            _dropdown(
              'Dependents',
              'Dependents',
              ['Yes', 'No'],
            ),

            const SizedBox(height: 24),

            _sectionTitle('Account Information'),

            _numberField(
              'Tenure (Months)',
              tenureController,
              max: 72,
            ),

            _dropdown(
              'Contract',
              'Contract',
              [
                'Month-to-month',
                'One year',
                'Two year',
              ],
            ),

            _dropdown(
              'Paperless Billing',
              'PaperlessBilling',
              ['Yes', 'No'],
            ),

            const SizedBox(height: 24),

            _sectionTitle('Phone Services'),

            _dropdown(
              'Phone Service',
              'PhoneService',
              ['Yes', 'No'],
            ),

            _dropdown(
              'Multiple Lines',
              'MultipleLines',
              [
                'Yes',
                'No',
                'No phone service',
              ],
            ),

            const SizedBox(height: 24),

            _sectionTitle('Internet Services'),

            _dropdown(
              'Internet Service',
              'InternetService',
              [
                'DSL',
                'Fiber optic',
                'No',
              ],
            ),

            _dropdown(
              'Online Security',
              'OnlineSecurity',
              [
                'Yes',
                'No',
                'No internet service',
              ],
            ),

            _dropdown(
              'Online Backup',
              'OnlineBackup',
              [
                'Yes',
                'No',
                'No internet service',
              ],
            ),

            _dropdown(
              'Device Protection',
              'DeviceProtection',
              [
                'Yes',
                'No',
                'No internet service',
              ],
            ),

            _dropdown(
              'Tech Support',
              'TechSupport',
              [
                'Yes',
                'No',
                'No internet service',
              ],
            ),

            _dropdown(
              'Streaming TV',
              'StreamingTV',
              [
                'Yes',
                'No',
                'No internet service',
              ],
            ),

            _dropdown(
              'Streaming Movies',
              'StreamingMovies',
              [
                'Yes',
                'No',
                'No internet service',
              ],
            ),

            const SizedBox(height: 24),

            _sectionTitle('Billing Information'),

            _dropdown(
              'Payment Method',
              'PaymentMethod',
              [
                'Electronic check',
                'Mailed check',
                'Bank transfer (automatic)',
                'Credit card (automatic)',
              ],
            ),

            _numberField(
              'Monthly Charges',
              monthlyChargesController,
            ),

            _numberField(
              'Total Charges (Optional)',
              totalChargesController,
              optional: true,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                onPressed: isLoading ? null : _submitPrediction,
                icon: const Icon(Icons.psychology),
                label: Text(
                  isLoading
                      ? 'Predicting...'
                      : 'Predict Customer Churn',
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5),
                  foregroundColor: Colors.white,
                ),
              ),
            ),

            if (errorMessage != null) ...[
              const SizedBox(height: 20),
              Text(
                errorMessage!,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ],

            if (predictionResult != null) ...[
              const SizedBox(height: 24),
              _resultCard(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
          color: Color(0xFF312E81),
        ),
      ),
    );
  }

  Widget _dropdown(
    String label,
    String key,
    List<String> options,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: customerData[key],
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        items: options.map((option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              customerData[key] = value;
            });
          }
        },
      ),
    );
  }

  Widget _numberField(
    String label,
    TextEditingController controller, {
    bool optional = false,
    int? max,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: optional ? 'Leave blank if unavailable' : null,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return optional ? null : 'This field is required';
          }

          final number = double.tryParse(value.trim());

          if (number == null || !number.isFinite || number < 0) {
            return 'Enter a valid non-negative number';
          }

          if (max != null && number > max) {
            return 'Maximum allowed value is $max';
          }

          if (max != null && number != number.roundToDouble()) {
            return 'Enter a whole number';
          }

          return null;
        },
      ),
    );
  }

  Future<void> _submitPrediction() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
      predictionResult = null;
    });

    final Map<String, dynamic> requestData = {
      ...customerData,
      'SeniorCitizen': int.parse(customerData['SeniorCitizen']!),
      'tenure': int.parse(tenureController.text.trim()),
      'MonthlyCharges':
          double.parse(monthlyChargesController.text.trim()),
      'TotalCharges': totalChargesController.text.trim().isEmpty
          ? null
          : double.parse(totalChargesController.text.trim()),
    };

    try {
      final result = await PredictionService.predictChurn(
        requestData,
      );

      if (!mounted) return;

      setState(() {
        predictionResult = result;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Widget _resultCard() {
    final prediction =
        predictionResult!['prediction']?.toString() ?? 'Unknown';

    final probability = predictionResult!['churn_probability'];

    final probabilityValue = probability is num
        ? probability.toDouble()
        : double.tryParse(probability.toString()) ?? 0.0;

    final probabilityPercent = probabilityValue <= 1
        ? probabilityValue * 100
        : probabilityValue;

    final isChurn = prediction.toLowerCase() == 'churn';

    final resultColor = isChurn
        ? const Color(0xFFDC2626)
        : const Color(0xFF059669);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: resultColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Prediction Result',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            prediction,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: resultColor,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'Churn Probability: ${probabilityPercent.toStringAsFixed(2)}%',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 14),

          LinearProgressIndicator(
            value: (probabilityPercent / 100)
                .clamp(0.0, 1.0)
                .toDouble(),
            minHeight: 10,
            backgroundColor: const Color(0xFFE5E7EB),
            color: resultColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ],
      ),
    );
  }
}
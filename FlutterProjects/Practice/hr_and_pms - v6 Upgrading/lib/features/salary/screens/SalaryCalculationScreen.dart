import 'package:flutter/material.dart';

class SalaryCalculationScreen extends StatefulWidget {
  const SalaryCalculationScreen({super.key});

  @override
  _SalaryCalculationScreenState createState() => _SalaryCalculationScreenState();
}

class _SalaryCalculationScreenState extends State<SalaryCalculationScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final TextEditingController _basicSalaryController = TextEditingController();
  final TextEditingController _daController = TextEditingController();
  final TextEditingController _hraController = TextEditingController();
  final TextEditingController _pfEmployeeShareController = TextEditingController();
  final TextEditingController _pfOrgShareController = TextEditingController();
  final TextEditingController _esiEmployeeShareController = TextEditingController();
  final TextEditingController _esiOrgShareController = TextEditingController();

  double _netSalary = 0.0;

  void _calculateSalary() {
    if (_formKey.currentState?.validate() ?? false) {
      final double basicSalary = double.tryParse(_basicSalaryController.text) ?? 0.0;
      final double daPercentage = double.tryParse(_daController.text) ?? 0.0;
      final double hraPercentage = double.tryParse(_hraController.text) ?? 0.0;
      final double pfEmployeeSharePercentage = double.tryParse(_pfEmployeeShareController.text) ?? 0.0;
      final double pfOrgSharePercentage = double.tryParse(_pfOrgShareController.text) ?? 0.0;
      final double esiEmployeeSharePercentage = double.tryParse(_esiEmployeeShareController.text) ?? 0.0;
      final double esiOrgSharePercentage = double.tryParse(_esiOrgShareController.text) ?? 0.0;

      final double daAmount = basicSalary * (daPercentage / 100);
      final double hraAmount = basicSalary * (hraPercentage / 100);
      final double pfEmployeeShare = basicSalary * (pfEmployeeSharePercentage / 100);
      final double pfOrgShare = basicSalary * (pfOrgSharePercentage / 100);
      final double esiEmployeeShare = basicSalary * (esiEmployeeSharePercentage / 100);
      final double esiOrgShare = basicSalary * (esiOrgSharePercentage / 100);

      final double totalEarnings = basicSalary + daAmount + hraAmount;
      final double totalDeductions = pfEmployeeShare + pfOrgShare + esiEmployeeShare + esiOrgShare;

      setState(() {
        _netSalary = totalEarnings - totalDeductions;
      });
    }
  }

  void _resetFields() {
    setState(() {
      _basicSalaryController.clear();
      _daController.clear();
      _hraController.clear();
      _pfEmployeeShareController.clear();
      _pfOrgShareController.clear();
      _esiEmployeeShareController.clear();
      _esiOrgShareController.clear();
      _netSalary = 0.0;
    });
  }

  @override
  void dispose() {
    _basicSalaryController.dispose();
    _daController.dispose();
    _hraController.dispose();
    _pfEmployeeShareController.dispose();
    _pfOrgShareController.dispose();
    _esiEmployeeShareController.dispose();
    _esiOrgShareController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salary Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Salary Settings',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                _buildTextField(
                  label: 'Basic Salary',
                  controller: _basicSalaryController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Please enter a valid basic salary';
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'DA (%)',
                        controller: _daController,
                        validator: (value) => _validatePercentage(value),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        label: 'HRA (%)',
                        controller: _hraController,
                        validator: (value) => _validatePercentage(value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                const Text(
                  'Provident Fund Settings',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'Employee Share (%)',
                        controller: _pfEmployeeShareController,
                        validator: (value) => _validatePercentage(value),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        label: 'Organization Share (%)',
                        controller: _pfOrgShareController,
                        validator: (value) => _validatePercentage(value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                const Text(
                  'ESI Settings',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'Employee Share (%)',
                        controller: _esiEmployeeShareController,
                        validator: (value) => _validatePercentage(value),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        label: 'Organization Share (%)',
                        controller: _esiOrgShareController,
                        validator: (value) => _validatePercentage(value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                Center(
                  child: Text(
                    'Net Salary: \$${_netSalary.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 40),

                // Buttons to calculate and reset
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: _calculateSalary,
                      child: const Text('Calculate Salary'),
                    ),
                    ElevatedButton(
                      onPressed: _resetFields,
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to create text fields
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      keyboardType: TextInputType.number,
      validator: validator,
    );
  }

  // Helper method to validate percentage inputs
  String? _validatePercentage(String? value) {
    if (value?.isEmpty ?? true) return 'Please enter a valid percentage';
    final double? percentage = double.tryParse(value!);
    if (percentage == null || percentage < 0 || percentage > 100) {
      return 'Please enter a valid percentage between 0 and 100';
    }
    return null;
  }
}

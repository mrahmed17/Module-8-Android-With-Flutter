import 'package:flutter/material.dart';
import 'package:hr_and_pms/features/salary/service/SalaryService.dart';
import 'package:hr_and_pms/features/salary/model/Salary.dart';

class SalaryReportManagementScreen extends StatefulWidget {
  const SalaryReportManagementScreen({Key? key}) : super(key: key);

  @override
  _SalaryReportManagementScreenState createState() =>
      _SalaryReportManagementScreenState();
}

class _SalaryReportManagementScreenState
    extends State<SalaryReportManagementScreen> {
  final SalaryService _salaryService = SalaryService();

  bool _isLoading = false;
  List<Salary> _salaryReports = [];
  String? _errorMessage;

  // Fetches salary reports from the service
  Future<void> _fetchSalaryReports() async {
    setState(() {
      _isLoading = true;
      _salaryReports = [];
      _errorMessage = null;
    });

    try {
      // Assuming the SalaryService has a method to fetch reports, you can implement pagination or filters if needed.
      final salaryReports = await _salaryService.getAllSalaries();

      setState(() {
        _salaryReports = salaryReports;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSalaryReports(); // Fetch the reports when the screen is loaded
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salary Report Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchSalaryReports, // Refresh the report list
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage != null
            ? Center(
          child: Text(
            _errorMessage!,
            style: const TextStyle(color: Colors.red),
          ),
        )
            : _salaryReports.isEmpty
            ? const Center(child: Text('No salary reports available'))
            : ListView.builder(
          itemCount: _salaryReports.length,
          itemBuilder: (context, index) {
            final salary = _salaryReports[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text('User Name: ${salary.userId?.name}', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Net Salary: \$${salary.netSalary}'),
                    Text('Tax: \$${salary.tax}'),
                    Text(
                        'Provident Fund: \$${salary.providentFund}'),
                    // Text('Total Salary: \$${salary.totalSalary}'),
                    Text('Payment Date: ${salary.paymentDate}'),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    // You can handle more actions like viewing details or deleting the salary
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

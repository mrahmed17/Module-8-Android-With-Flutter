import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CreatePaySlipScreen extends StatelessWidget {
  // Example PaySlip Data
  final String employeeName = 'John Doe';
  final String employeeId = '12345';
  final String billingDate = '2024-11-30';
  final String paymentMethod = 'Bank Transfer';
  final double basicSalary = 3000.00;
  final double bonus = 500.00;
  final double overtime = 150.00;
  final double leaveDeduction = 100.00;
  final double taxDeduction = 450.00;
  final double providentFundDeduction = 150.00;
  final double netSalary = 2950.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pay Slip')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('=== Payslip for $employeeName ===', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            _buildInfoRow('Employee ID:', employeeId),
            _buildInfoRow('Billing Date:', billingDate),
            _buildInfoRow('Payment Method:', paymentMethod),
            SizedBox(height: 30),
            _buildSectionTitle('Earnings:'),
            _buildInfoRow('Basic Salary:', '\$$basicSalary'),
            _buildInfoRow('Bonus:', '\$$bonus'),
            _buildInfoRow('Overtime:', '\$$overtime'),
            SizedBox(height: 20),
            _buildSectionTitle('Deductions:'),
            _buildInfoRow('Leave Deduction:', '-\$$leaveDeduction'),
            _buildInfoRow('Tax Deduction:', '-\$$taxDeduction'),
            _buildInfoRow('Provident Fund Deduction:', '-\$$providentFundDeduction'),
            SizedBox(height: 20),
            _buildSectionTitle('Net Salary:'),
            _buildInfoRow('Net Salary:', '\$$netSalary'),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _generateAndDownloadPdf();
                },
                child: Text('Download Payslip'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build rows for info display
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text('$label', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 10),
          Text(value),
        ],
      ),
    );
  }

  // Helper function to build section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  // Function to generate and download the PDF
  Future<void> _generateAndDownloadPdf() async {
    final pdf = pw.Document();

    // Add content to PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('=== Payslip for $employeeName ===', style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              _buildPdfRow('Employee ID:', employeeId),
              _buildPdfRow('Billing Date:', billingDate),
              _buildPdfRow('Payment Method:', paymentMethod),
              pw.SizedBox(height: 30),
              pw.Text('Earnings:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              _buildPdfRow('Basic Salary:', '\$$basicSalary'),
              _buildPdfRow('Bonus:', '\$$bonus'),
              _buildPdfRow('Overtime:', '\$$overtime'),
              pw.SizedBox(height: 20),
              pw.Text('Deductions:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              _buildPdfRow('Leave Deduction:', '-\$$leaveDeduction'),
              _buildPdfRow('Tax Deduction:', '-\$$taxDeduction'),
              _buildPdfRow('Provident Fund Deduction:', '-\$$providentFundDeduction'),
              pw.SizedBox(height: 20),
              pw.Text('Net Salary:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              _buildPdfRow('Net Salary:', '\$$netSalary'),
            ],
          );
        },
      ),
    );

    // Save PDF and initiate download
    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  // Helper function to create PDF rows
  pw.Widget _buildPdfRow(String label, String value) {
    return pw.Row(
      children: [
        pw.Text(label, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(width: 10),
        pw.Text(value),
      ],
    );
  }
}

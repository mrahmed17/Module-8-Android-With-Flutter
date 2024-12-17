import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw; // for PDF generation
import 'package:path_provider/path_provider.dart'; // for getting file paths
import 'dart:io';
import 'package:csv/csv.dart';

class PaySlipScreen extends StatefulWidget {
  const PaySlipScreen({super.key});

  @override
  _PaySlipScreenState createState() => _PaySlipScreenState();
}

class _PaySlipScreenState extends State<PaySlipScreen> {
  final TextEditingController _basicSalaryController = TextEditingController();
  double basicSalary = 6500;
  double houseRentAllowance = 0.0;
  double conveyance = 0.0;
  double otherAllowance = 0.0;
  double totalEarnings = 0.0;
  double tds = 0.0;
  double providentFund = 0.0;
  double esi = 0.0;
  double loan = 300.0;
  double totalDeductions = 0.0;
  double netSalary = 0.0;

  @override
  void initState() {
    super.initState();
    _basicSalaryController.text = basicSalary.toString();
    _calculateSalary();
  }

  void _calculateSalary() {
    setState(() {
      basicSalary = double.tryParse(_basicSalaryController.text) ?? 6500;
      houseRentAllowance = basicSalary * 0.08;
      conveyance = basicSalary * 0.05;
      otherAllowance = basicSalary * 0.02;

      totalEarnings = basicSalary + houseRentAllowance + conveyance + otherAllowance;

      tds = 0.0;
      providentFund = 0.0;
      esi = 0.0;
      loan = 300.0;

      totalDeductions = tds + providentFund + esi + loan;

      netSalary = totalEarnings - totalDeductions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payslip'),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _downloadCSV,
          ),
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: _downloadPDF,
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              // Add functionality for printing here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderSection(),
            SizedBox(height: 16.0),
            EmployeeDetails(),
            SizedBox(height: 16.0),
            _buildBasicSalaryInput(),
            SizedBox(height: 16.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: EarningsTable(basicSalary, houseRentAllowance, conveyance, otherAllowance, totalEarnings)),
                SizedBox(width: 8.0),
                Expanded(child: DeductionsTable(tds, providentFund, esi, loan, totalDeductions)),
              ],
            ),
            SizedBox(height: 16.0),
            NetSalary(netSalary),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicSalaryInput() {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Basic Salary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _basicSalaryController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Basic Salary',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _calculateSalary(),
            ),
          ],
        ),
      ),
    );
  }

  void _downloadCSV() async {
    List<List<String>> data = [
      ["Description", "Amount"],
      ["Basic Salary", basicSalary.toString()],
      ["House Rent Allowance (H.R.A.)", houseRentAllowance.toString()],
      ["Conveyance", conveyance.toString()],
      ["Other Allowance", otherAllowance.toString()],
      ["Total Earnings", totalEarnings.toString()],
      ["Tax Deducted at Source (T.D.S.)", tds.toString()],
      ["Provident Fund", providentFund.toString()],
      ["ESI", esi.toString()],
      ["Loan", loan.toString()],
      ["Total Deductions", totalDeductions.toString()],
      ["Net Salary", netSalary.toString()],
    ];

    String csvData = const ListToCsvConverter().convert(data);
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/payslip.csv";
    final file = File(path);
    await file.writeAsString(csvData);
    print('CSV downloaded at $path');
  }

  void _downloadPDF() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Payslip for November 2024"),
            pw.SizedBox(height: 16),
            pw.Text("Employee Name: Rezvi"),
            pw.Text("Position: IT Officer"),
            pw.Text("Employee ID: NS-0001"),
            pw.SizedBox(height: 16),
            pw.Text("Earnings:"),
            pw.Table.fromTextArray(data: [
              ["Basic Salary", basicSalary.toString()],
              ["House Rent Allowance (H.R.A.)", houseRentAllowance.toString()],
              ["Conveyance", conveyance.toString()],
              ["Other Allowance", otherAllowance.toString()],
              ["Total Earnings", totalEarnings.toString()]
            ]),
            pw.SizedBox(height: 16),
            pw.Text("Deductions:"),
            pw.Table.fromTextArray(data: [
              ["Tax Deducted at Source (T.D.S.)", tds.toString()],
              ["Provident Fund", providentFund.toString()],
              ["ESI", esi.toString()],
              ["Loan", loan.toString()],
              ["Total Deductions", totalDeductions.toString()]
            ]),
            pw.SizedBox(height: 16),
            pw.Text("Net Salary: \$${netSalary.toString()}"),
          ],
        ),
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/payslip.pdf";
    final file = File(path);
    await file.writeAsBytes(await pdf.save());
    print('PDF downloaded at $path');
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/images/carousel/bonus.jpg', height: 100, width: 200,),
        SizedBox(height: 8.0),
        Text(
          'Kormi Seba',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.teal),
          textAlign: TextAlign.center,
        ),
        Text('38, IsDB Bhavan, Agargaon'),
        Text('North Dhaka, Dhaka, Bangladesh'),
        SizedBox(height: 16.0),
        Text(
          'Payslip for the month of $DateTime',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 4.0),
        Text('Payslip #49029 | Salary Month: November, 2024'),
      ],
    );
  }
}

class EmployeeDetails extends StatelessWidget {
  const EmployeeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rezvi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('IT Officer'),
            Text('Employee ID: NS-0001'),
            Text('Joining Date: 7 June, 2024'),
          ],
        ),
      ),
    );
  }
}

class EarningsTable extends StatelessWidget {
  final double basicSalary, houseRentAllowance, conveyance, otherAllowance, totalEarnings;

  const EarningsTable(this.basicSalary, this.houseRentAllowance, this.conveyance, this.otherAllowance, this.totalEarnings, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Earnings',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  TableCell(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Basic Salary', style: TextStyle(fontSize: 14)),
                  )),
                  TableCell(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('\$' + basicSalary.toString(), style: TextStyle(fontSize: 14)),
                  )),
                ]),
                TableRow(children: [
                  TableCell(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('House Rent Allowance (H.R.A.)', style: TextStyle(fontSize: 14)),
                  )),
                  TableCell(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('\$' + houseRentAllowance.toString(), style: TextStyle(fontSize: 14)),
                  )),
                ]),
                TableRow(children: [
                  TableCell(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Conveyance', style: TextStyle(fontSize: 14)),
                  )),
                  TableCell(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('\$' + conveyance.toString(), style: TextStyle(fontSize: 14)),
                  )),
                ]),
                TableRow(children: [
                  TableCell(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Other Allowance', style: TextStyle(fontSize: 14)),
                  )),
                  TableCell(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('\$' + otherAllowance.toString(), style: TextStyle(fontSize: 14)),
                  )),
                ]),
                TableRow(children: [
                  TableCell(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Total Earnings', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  )),
                  TableCell(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('\$' + totalEarnings.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  )),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DeductionsTable extends StatelessWidget {
  final double tds, providentFund, esi, loan, totalDeductions;

  const DeductionsTable(this.tds, this.providentFund, this.esi, this.loan, this.totalDeductions, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deductions',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  TableCell(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Tax Deducted at Source (T.D.S.)', style: TextStyle(fontSize: 14)),
                  )),
                  TableCell(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('\$' + tds.toString(), style: TextStyle(fontSize: 14)),
                  )),
                ]),
                TableRow(children: [
                  TableCell(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Provident Fund', style: TextStyle(fontSize: 14)),
                  )),
                  TableCell(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('\$' + providentFund.toString(), style: TextStyle(fontSize: 14)),
                  )),
                ]),
                TableRow(children: [
                  TableCell(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('ESI', style: TextStyle(fontSize: 14)),
                  )),
                  TableCell(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('\$' + esi.toString(), style: TextStyle(fontSize: 14)),
                  )),
                ]),
                TableRow(children: [
                  TableCell(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Loan', style: TextStyle(fontSize: 14)),
                  )),
                  TableCell(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('\$' + loan.toString(), style: TextStyle(fontSize: 14)),
                  )),
                ]),
                TableRow(children: [
                  TableCell(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Total Deductions', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  )),
                  TableCell(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('\$' + totalDeductions.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  )),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NetSalary extends StatelessWidget {
  final double netSalary;

  const NetSalary(this.netSalary, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Net Salary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              '\$' + netSalary.toString(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:hr_and_pms/administration/model/User.dart';
import 'package:hr_and_pms/features/leave/model/RequestStatus.dart';

class Salary {
  int? id;
  User? userId;
  double netSalary;
  double tax;
  double providentFund;
  double? totalSalary;
  DateTime paymentDate;
  RequestStatus salaryStatus;

  Salary({
    this.id,
    this.userId,
    required this.netSalary,
    required this.tax,
    required this.providentFund,
    this.totalSalary,
    required this.paymentDate,
    required this.salaryStatus,
  });

  factory Salary.fromJson(Map<String, dynamic> json) {
    return Salary(
      id: json['id'],
      userId: json['userId'] != null ? User.fromJson(json['userId']) : null,
      netSalary: json['netSalary'],
      tax: json['tax'],
      providentFund: json['providentFund'],
      totalSalary: json['totalSalary'],
      paymentDate: DateTime.parse(json['paymentDate']),
      salaryStatus: RequestStatusExtension.fromString(json['salaryStatus']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId?.toJson(),
      'netSalary': netSalary,
      'tax': tax,
      'providentFund': providentFund,
      'totalSalary': totalSalary,
      'paymentDate': paymentDate.toIso8601String(),
      'salaryStatus': salaryStatus.toShortString(),
    };
  }



Salary copyWith({
    int? id,
    User? userId,
    double? netSalary,
    double? tax,
    double? providentFund,
    double? totalSalary,
    DateTime? paymentDate,
    RequestStatus? salaryStatus,
  }) {
    return Salary(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      netSalary: netSalary ?? this.netSalary,
      tax: tax ?? this.tax,
      providentFund: providentFund ?? this.providentFund,
      totalSalary: totalSalary ?? this.totalSalary,
      paymentDate: paymentDate ?? this.paymentDate,
      salaryStatus: salaryStatus ?? this.salaryStatus,
    );
  }


}

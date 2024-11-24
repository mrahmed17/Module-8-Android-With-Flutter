import 'package:hr_and_pms/administration/model/User.dart';
import 'package:hr_and_pms/features/leave/model/RequestStatus.dart'; // Import the enum

class AdvanceSalary {
  int? id;
  double? advanceAmount; // Changed to match the naming convention
  String? reason;
  DateTime? advanceDate;
  User? user;
  RequestStatus? status;
  bool? isPaid;
  DateTime? paidDate;

  AdvanceSalary({
    this.id,
    this.advanceAmount,
    this.reason,
    this.advanceDate,
    this.user,
    this.status,
    this.isPaid,
    this.paidDate,
  });

  // Method to convert JSON to AdvanceSalary instance
  factory AdvanceSalary.fromJson(Map<String, dynamic> json) {
    return AdvanceSalary(
      id: json['id'] ?? 0,
      advanceAmount: json['advanceAmount']?.toDouble() ?? 0.0, // Corrected naming
      reason: json['reason'] ?? '',
      advanceDate: DateTime.tryParse(json['advanceDate'] ?? DateTime.now().toIso8601String()) ?? DateTime.now(),
      user: json['user'] != null ? User.fromJson(json['user']) : null, // Ensure user is not null
      status: RequestStatusExtension.fromString(json['status'] ?? 'PENDING'),
      isPaid: json['isPaid'] ?? false,
      paidDate: json['paidDate'] != null ? DateTime.tryParse(json['paidDate']) : null,
    );
  }

  // Method to convert AdvanceSalary instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'advanceAmount': advanceAmount, // Corrected naming
      'reason': reason,
      'advanceDate': advanceDate?.toIso8601String(),
      'user': user?.toJson(),
      'status': status?.toShortString(), // Serialize status as short string
      'isPaid': isPaid, // Added to JSON
      'paidDate': paidDate?.toIso8601String(), // Added to JSON
    };
  }
}
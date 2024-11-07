

import 'package:hr_and_payroll_management/features/user/models/Role.dart';
import 'package:hr_and_payroll_management/models/Attendance.dart';

class User {
  final int id;
  final String fullName;
  final String email;
  final String password;
  final String address;
  final String gender;
  final DateTime dateOfBirth;
  final String nationalId;
  final String contact;
  final double basicSalary;
  final DateTime joinedDate;
  final String profilePhoto;
  final Role role;
  final List<Attendance> attendances;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.address,
    required this.gender,
    required this.dateOfBirth,
    required this.nationalId,
    required this.contact,
    required this.basicSalary,
    required this.joinedDate,
    required this.profilePhoto,
    required this.role,
    required this.attendances,
  });

  // Method to convert JSON to User instance
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      address: json['address'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: DateTime.parse(json['dateOfBirth'] ?? DateTime.now().toString()),
      nationalId: json['nationalId'] ?? '',
      contact: json['contact'] ?? '',
      basicSalary: json['basicSalary']?.toDouble() ?? 0.0,
      joinedDate: DateTime.parse(json['joinedDate'] ?? DateTime.now().toString()),
      profilePhoto: json['profilePhoto'] ?? '',
      role: Role.values.firstWhere((e) => e.toString() == 'Role.${json['role']}'),
      attendances: (json['attendances'] as List<dynamic>?)
          ?.map((attendance) => Attendance.fromJson(attendance))
          .toList() ??
          [],
    );
  }

  // Method to convert User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
      'address': address,
      'gender': gender,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'nationalId': nationalId,
      'contact': contact,
      'basicSalary': basicSalary,
      'joinedDate': joinedDate.toIso8601String(),
      'profilePhoto': profilePhoto,
      'role': role.toString().split('.').last,
      'attendances': attendances.map((attendance) => attendance.toJson()).toList(),
    };
  }
}
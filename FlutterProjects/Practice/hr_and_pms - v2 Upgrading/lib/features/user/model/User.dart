
import 'package:hr_and_pms/features/attendance/dto/AttendanceDTO.dart';
import 'package:hr_and_pms/features/attendance/model/AttendanceModel.dart';
import 'package:hr_and_pms/features/user/model/Role.dart';

class User {
  final int id;
  final String name;
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
    required this.name,
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
    this.attendances = const [],
  });

// Factory constructor to create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      address: json['address'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: DateTime.tryParse(json['dateOfBirth'] ?? '') ?? DateTime.now(),
      nationalId: json['nationalId'] ?? '',
      contact: json['contact'] ?? '',
      basicSalary: (json['basicSalary'] ?? 0).toDouble(),
      joinedDate: DateTime.tryParse(json['joinedDate'] ?? '') ?? DateTime.now(),
      profilePhoto: json['profilePhoto'] ?? '',
      role: RoleExtension.fromString(json['role'] ?? 'EMPLOYEE'),
      attendances: (json['attendances'] as List<dynamic>?)
          ?.map((attendance) => Attendance.fromJson(attendance))
          .toList() ??
          [],
    );
  }

  // Convert User object to UserDTO
  UserDTO toDTO() {
    return UserDTO(
      id: this.id,
      name: this.name,
      email: this.email,
      cell: this.contact,
      address: this.address,
      dateOfBirth: this.dateOfBirth,
      gender: this.gender,
      basicSalary: this.basicSalary,
      joinedDate: this.joinedDate,
      active: true, // Adjust this value based on your logic
      profilePhoto: this.profilePhoto,
      role: this.role,
    );
  }


  // Method to convert User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': name,
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
      'role': role.toShortString(),
      'attendances': attendances.map((attendance) => attendance.toJson()).toList(),
    };
  }
}

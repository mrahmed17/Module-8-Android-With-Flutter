import 'package:hr_and_pms/features/attendance/model/AttendanceModel.dart';
import 'package:hr_and_pms/administration/model/Role.dart';
import 'package:hr_and_pms/features/leave/model/LeaveType.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String? password;
  final String cell;
  final String address;
  final DateTime? dateOfBirth;
  final String gender;
  final double basicSalary;
  final DateTime joinedDate;
  final Map<LeaveType, int> leaveBalance; // Map for leave balance
  final String profilePhoto;
  final Role role;
  final List<Attendance> attendances;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    required this.address,
    required this.gender,
    this.dateOfBirth,
    required this.cell,
    required this.basicSalary,
    required this.joinedDate,
    required this.leaveBalance,
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
      password: json['password'], // Keep it nullable
      address: json['address'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.tryParse(json['dateOfBirth']) : null,
      cell: json['cell'] ?? '',
      basicSalary: (json['basicSalary'] ?? 0).toDouble(),
      joinedDate: DateTime.tryParse(json['joinedDate'] ?? '') ?? DateTime.now(),
      leaveBalance: (json['leaveBalance'] as Map<String, dynamic>?)
          ?.map((key, value) {
        // Adjust the key so that it removes the "LeaveType." prefix
        String enumKey = key.replaceAll('LeaveType.', '');
        return MapEntry(LeaveTypeExtension.fromString(enumKey), value as int);
      }) ?? {},
      profilePhoto: json['profilePhoto'] ?? '',
      role: RoleExtension.fromString(json['role'] ?? 'EMPLOYEE'),
      attendances: (json['attendances'] as List<dynamic>?)
          ?.map((attendance) => Attendance.fromJson(attendance))
          .toList() ?? [],
    );
  }


  // Method to convert User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'gender': gender,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'cell': cell,
      'basicSalary': basicSalary,
      'joinedDate': joinedDate.toIso8601String(),
      'leaveBalance': leaveBalance.map((key, value) => MapEntry(key.toString(), value)),
      'profilePhoto': profilePhoto,
      'role': role.toShortString(),
      'attendances': attendances.map((attendance) => attendance.toJson()).toList(),
    };
  }
}


//
  // // Add the copyWith method here
  // User copyWith({
  //   int? id,
  //   String? name,
  //   String? email,
  //   String? password,
  //   String? cell,
  //   String? address,
  //   DateTime? dateOfBirth,
  //   String? gender,
  //   double? basicSalary,
  //   DateTime? joinedDate,
  //   Map<LeaveType, int>? leaveBalance,
  //   String? profilePhoto,
  //   Role? role,
  //   List<Attendance>? attendances,
  // }) {
  //   return User(
  //     id: id ?? this.id,
  //     name: name ?? this.name,
  //     email: email ?? this.email,
  //     password: password ?? this.password,
  //     cell: cell ?? this.cell,
  //     address: address ?? this.address,
  //     dateOfBirth: dateOfBirth ?? this.dateOfBirth,
  //     gender: gender ?? this.gender,
  //     basicSalary: basicSalary ?? this.basicSalary,
  //     joinedDate: joinedDate ?? this.joinedDate,
  //     leaveBalance: leaveBalance ?? this.leaveBalance,
  //     profilePhoto: profilePhoto ?? this.profilePhoto,
  //     role: role ?? this.role,
  //     attendances: attendances ?? this.attendances,
  //   );
  // }
  //
  // factory User.empty() {
  //   return User(
  //     id: 0,
  //     name: '',
  //     email: '',
  //     password: null,
  //     address: '',
  //     gender: '',
  //     dateOfBirth: null,
  //     cell: '',
  //     basicSalary: 0.0,
  //     joinedDate: DateTime(1900, 1, 1),
  //     leaveBalance: {},
  //     profilePhoto: '',
  //     role: Role.EMPLOYEE,
  //     attendances: [],
  //   );
  // }


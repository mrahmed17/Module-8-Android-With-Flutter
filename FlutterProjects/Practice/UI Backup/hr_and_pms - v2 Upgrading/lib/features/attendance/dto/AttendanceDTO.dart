import 'package:hr_and_pms/features/user/model/Role.dart';

class UserDTO {
  final int id;
  final String name;
  final String email;
  final String cell;
  final String address;
  final DateTime dateOfBirth;
  final String gender;
  final double basicSalary;
  final DateTime joinedDate;
  final bool active;
  final String profilePhoto;
  final Role role;

  UserDTO({
    required this.id,
    required this.name,
    required this.email,
    required this.cell,
    required this.address,
    required this.dateOfBirth,
    required this.gender,
    required this.basicSalary,
    required this.joinedDate,
    required this.active,
    required this.profilePhoto,
    required this.role,
  });

  // Factory constructor to create a UserDTO object from JSON
  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      cell: json['cell'],
      address: json['address'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender: json['gender'],
      basicSalary: json['basicSalary'].toDouble(),
      joinedDate: DateTime.parse(json['joinedDate']),
      active: json['active'],
      profilePhoto: json['profilePhoto'],
      role: RoleExtension.fromString(json['role']),
    );
  }

  // Method to convert UserDTO object into JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'cell': cell,
      'address': address,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'basicSalary': basicSalary,
      'joinedDate': joinedDate.toIso8601String(),
      'active': active,
      'profilePhoto': profilePhoto,
      'role': role.toShortString(),
    };
  }
}

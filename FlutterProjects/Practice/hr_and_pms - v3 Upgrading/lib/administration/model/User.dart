
import 'package:hr_and_pms/features/attendance/model/AttendanceModel.dart';
import 'package:hr_and_pms/administration/model/Role.dart';

class User {
   int? id;
   String? name;
   String? email;
   String? password;
   String? address;
   String? gender;
   DateTime? dateOfBirth;
   String? contact;
   double? basicSalary;
   DateTime? joinedDate;
   int? leaveBalance;
   String? profilePhoto;
   Role? role;
   List<Attendance> attendances;

  User({
     this.id,
     this.name,
     this.email,
     this.password,
     this.address,
     this.gender,
     this.dateOfBirth,
     this.contact,
     this.basicSalary,
     this.joinedDate,
     this.leaveBalance,
     this.profilePhoto,
     this.role,
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
      contact: json['contact'] ?? '',
      basicSalary: (json['basicSalary'] ?? 0).toDouble(),
      joinedDate: DateTime.tryParse(json['joinedDate'] ?? '') ?? DateTime.now(),
      leaveBalance:json['leaveBalance'] ?? 25,
      profilePhoto: json['profilePhoto'] ?? '',
      role: RoleExtension.fromString(json['role'] ?? 'EMPLOYEE'),
      attendances: (json['attendances'] as List<dynamic>?)
          ?.map((attendance) => Attendance.fromJson(attendance))
          .toList() ??
          [],
    );
  }


  factory User.empty() {
    return User(
      id: 0,
      name: '',
      email: '',
      password: '',
      address: '',
      gender: '',
      dateOfBirth: DateTime(1900, 1, 1),
      contact: '',
      basicSalary: 0.0,
      joinedDate: DateTime(1900, 1, 1),
      leaveBalance: 25,
      profilePhoto: '',
      role: Role.employee,
      attendances: [],
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
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'contact': contact,
      'basicSalary': basicSalary,
      'joinedDate': joinedDate?.toIso8601String(),
      'leaveBalance': leaveBalance,
      'profilePhoto': profilePhoto,
      'role': role?.toShortString(),
      'attendances': attendances.map((attendance) => attendance.toJson()).toList(),
    };
  }


}


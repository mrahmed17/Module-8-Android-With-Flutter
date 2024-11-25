import 'package:hr_and_pms/administration/model/User.dart';
import 'package:hr_and_pms/features/bonus/model/BonusType.dart'; // Make sure this import is correct
import '../../salary/model/Salary.dart';

class Bonus {
  int? id;
  double? bonusAmount;
  DateTime? bonusDate;
  BonusType? bonusType;
  User? user;

  Bonus({
    this.id,
    this.bonusAmount,
    this.bonusDate,
    this.bonusType,
    this.user,
  });

  // Factory constructor to create Bonus object from JSON
  factory Bonus.fromJson(Map<String, dynamic> json) {
    return Bonus(
      id: json['id'] ?? 0,
      bonusAmount: (json['bonusAmount'] ?? 0).toDouble(),
      bonusDate: json['bonusDate'] != null
          ? DateTime.tryParse(json['bonusDate'])
          : null,
      bonusType: BonusTypeExtension.fromString(json['bonusType'] ?? ''),
      user: json['user'] != null ? User.fromJson(json['user']) : null, // Deserialize User
    );
  }

  // Method to convert Bonus object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bonusAmount': bonusAmount,
      'bonusDate': bonusDate?.toIso8601String(),
      'bonusType': bonusType?.toShortString().toUpperCase(),
      'user': user?.toJson(),
    };
  }
}

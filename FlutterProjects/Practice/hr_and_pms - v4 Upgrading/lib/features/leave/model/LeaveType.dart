enum LeaveType { SICK, UNPAID, RESERVE }

extension LeaveTypeExtension on LeaveType {
  static LeaveType fromString(String leaveTypeString) {
    return LeaveType.values.firstWhere(
          (leaveType) => leaveType.toString().split('.').last.toUpperCase() == leaveTypeString.toUpperCase(),
      // orElse: () => LeaveType.SICK,  // Default to SICK if the value is not found
    );
  }

  String toShortString() {
    return toString().split('.').last.toUpperCase();  // Ensure it's in uppercase
  }
}


// enum LeaveType {
//   sick,
//   unpaid,
//   reserve,
// }
//
// // Convert enum to a string for JSON
// String leaveTypeToJson(LeaveType type) {
//   return type.toString().split('.').last;
// }
//
// // Parse string to enum from JSON
// LeaveType leaveTypeFromJson(String? type) {
//   switch (type) {
//     case 'sick':
//       return LeaveType.sick;
//     case 'unpaid':
//       return LeaveType.unpaid;
//     case 'reserve':
//       return LeaveType.reserve;
//     default:
//       print('Warning: Unknown leave type "$type". Defaulting to "sick".');
//       return LeaveType.sick;  // Default value
//       throw Exception('Unknown leave type');
//   }
// }

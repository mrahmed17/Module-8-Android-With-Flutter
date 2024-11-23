enum LeaveType {
  sick,
  unpaid,
  reserve,
}

// Convert enum to a string for JSON
String leaveTypeToJson(LeaveType type) {
  return type.toString().split('.').last;
}

// Parse string to enum from JSON
LeaveType leaveTypeFromJson(String? type) {
  switch (type) {
    case 'sick':
      return LeaveType.sick;
    case 'unpaid':
      return LeaveType.unpaid;
    case 'reserve':
      return LeaveType.reserve;
    default:
      print('Warning: Unknown leave type "$type". Defaulting to "sick".');
      return LeaveType.sick;  // Default value
      throw Exception('Unknown leave type');
  }
}

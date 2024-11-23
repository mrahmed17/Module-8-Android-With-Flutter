enum RequestStatus {
  approved,
  pending,
  rejected,
}

// Convert enum to a string for JSON
String requestStatusToJson(RequestStatus status) {
  return status.toString().split('.').last;
}

// Parse string to enum from JSON
RequestStatus requestStatusFromJson(String? status) {
  switch (status) {
    case 'approved':
      return RequestStatus.approved;
    case 'pending':
      return RequestStatus.pending;
    case 'rejected':
      return RequestStatus.rejected;
    default:
      print('Warning: Unknown request status "$status". Defaulting to "pending".');
      return RequestStatus.pending;  // Default value
      throw Exception('Unknown request status');
  }
}

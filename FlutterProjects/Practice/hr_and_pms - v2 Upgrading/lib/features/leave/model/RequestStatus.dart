enum RequestStatus { pending, approved, rejected }

extension RequestStatusExtension on RequestStatus {
  static RequestStatus fromString(String statusString) {
    return RequestStatus.values.firstWhere(
          (status) =>
      status.toString().split('.').last.toLowerCase() ==
          statusString.toLowerCase(),
      orElse: () => RequestStatus.pending,
    );
  }

  String toShortString() {
    return toString().split('.').last.toUpperCase();
  }
}

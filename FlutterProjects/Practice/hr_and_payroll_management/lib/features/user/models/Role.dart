enum Role { admin, manager, employee }

extension RoleExtension on Role {
  // Convert a string to Role enum
  static Role fromString(String roleString) {
    return Role.values.firstWhere((role) => role.toString().split('.').last.toLowerCase() == roleString.toLowerCase());
  }

  // Convert Role enum to a string
  String toShortString() {
    return toString().split('.').last;
  }
}

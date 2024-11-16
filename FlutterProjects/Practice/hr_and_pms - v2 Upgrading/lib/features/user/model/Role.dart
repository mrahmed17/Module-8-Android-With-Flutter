enum Role { ADMIN, MANAGER, EMPLOYEE }

extension RoleExtension on Role {
  // Convert String to Role enum value, case-insensitive
  static Role fromString(String roleString) {
    return Role.values.firstWhere(
          (role) => role.toString().split('.').last.toLowerCase() == roleString.toLowerCase(),
      orElse: () => Role.EMPLOYEE, // Default role if no match found
    );
  }

  // Convert Role enum to a string representation
  String toShortString() {
    return toString().split('.').last; // Gets the name of the role
  }
}

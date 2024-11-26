enum Role { ADMIN, MANAGER, EMPLOYEE }

extension RoleExtension on Role {
    static Role fromString(String roleString) {
    return Role.values.firstWhere(
          (role) => role.toString().split('.').last.toUpperCase() == roleString.toUpperCase(),
      orElse: () => Role.EMPLOYEE,
    );
  }

  String toShortString() {
    return toString().split('.').last.toUpperCase();
  }
}

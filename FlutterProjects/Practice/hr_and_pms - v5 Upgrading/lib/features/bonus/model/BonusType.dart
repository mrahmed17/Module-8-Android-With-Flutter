enum BonusType {PERFORMANCE, ANNUAL, FESTIVAL, PROMOTIONAL}

extension BonusTypeExtension on BonusType {
  static BonusType fromString(String bonusTypeString) {
    return BonusType.values.firstWhere(
          (bonusType) => bonusType.toString().split('.').
          last.toUpperCase() == bonusTypeString.toUpperCase(),
    );
  }

  String toShortString() {
    return toString().split('.').last.toUpperCase();
  }
}

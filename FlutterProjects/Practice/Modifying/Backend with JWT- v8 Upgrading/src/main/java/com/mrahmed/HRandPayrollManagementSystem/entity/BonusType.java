package com.mrahmed.HRandPayrollManagementSystem.entity;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

public enum BonusType {
    PERFORMANCE, ANNUAL, FESTIVAL, PROMOTIONAL;


    @JsonCreator
    public static BonusType fromString(String value) {
        return BonusType.valueOf(value.toUpperCase());
    }

    @JsonValue
    public String toJson() {
        return this.name();
    }
}
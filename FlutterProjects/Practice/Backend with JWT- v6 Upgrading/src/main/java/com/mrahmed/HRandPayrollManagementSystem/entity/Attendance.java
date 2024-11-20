package com.mrahmed.HRandPayrollManagementSystem.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "attendances")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString(exclude = "user")  // Prevent circular reference if User entity has AdvanceSalary relationship
public class Attendance {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    private LocalDate date;

    private LocalDateTime clockInTime;
    private LocalDateTime clockOutTime;

    private double overtimeHours; // Calculated based on business logic

    private boolean lateCheckIn; // Indicates late attendance

    @PrePersist
    @PreUpdate
    public void validateAttendance() {
        if (user == null) throw new IllegalArgumentException("User cannot be null.");
        if (date == null) throw new IllegalArgumentException("Date cannot be null.");
        if (clockInTime == null) throw new IllegalArgumentException("Clock-in time cannot be null.");
        if (clockOutTime != null && clockOutTime.isBefore(clockInTime)) {
            throw new IllegalArgumentException("Clock-out time must be after clock-in time.");
        }
    }


//    @Enumerated(EnumType.STRING)
//    private AttendanceMethod method; // ENUM: FINGERPRINT, FACE_SCAN, MANUAL
//
//    private String fingerprintHash; // Optional for fingerprint-based attendance
//    private String faceScanVector; // Optional for face-scan-based attendance

}

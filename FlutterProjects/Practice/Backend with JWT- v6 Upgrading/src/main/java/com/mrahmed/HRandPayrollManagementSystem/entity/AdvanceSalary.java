package com.mrahmed.HRandPayrollManagementSystem.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "advancesalaries")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString(exclude = "user")  // Prevent circular reference if User entity has AdvanceSalary relationship
public class AdvanceSalary {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private double advanceAmount;

    private String reason;

    private LocalDateTime advanceDate;

    @Enumerated(EnumType.STRING)
    private RequestStatus status;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    // Newly added field for tracking the approval of the advance salary
    private boolean isPaid;

    // Adding the applied date for salary calculation purposes
    private LocalDateTime paidDate;

    public void setIsPaid(boolean isPaid) {
        this.isPaid = isPaid;
    }

}

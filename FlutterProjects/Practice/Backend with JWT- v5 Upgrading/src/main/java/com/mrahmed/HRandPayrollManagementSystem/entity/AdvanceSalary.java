package com.mrahmed.HRandPayrollManagementSystem.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "advancesalaries")
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString(exclude = "user")  // Prevent circular reference if User entity has AdvanceSalary relationship
public class AdvanceSalary {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private double advanceSalary;

    private String reason;

    private LocalDateTime advanceDate;

    @ManyToOne(fetch = FetchType.LAZY)  // Lazy loading to improve performance if it's not needed eagerly
    @JoinColumn(name = "user_id")
    private User user;
}

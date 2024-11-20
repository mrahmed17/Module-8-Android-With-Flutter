package com.mrahmed.HRandPayrollManagementSystem.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "salaries")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString(exclude = {"user", "bonuses", "leaves", "overTime", "advanceAmount"})
public class Salary {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private LocalDateTime paymentDate; // Date of salary disbursement
    private double netSalary; // Final salary after all calculations
    private double tax; // Deductible tax
    private double providentFund; // Calculated as a percentage of baseSalary
    private String salaryStatus; // PENDING, PAID, etc.

    @OneToMany(fetch = FetchType.EAGER)
    @JoinColumn(name = "over_time")
    private List<Attendance> overTime; // Overtime attendances

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.PERSIST)
    @JoinColumn(name = "advance_salary_id")
    private AdvanceSalary advanceAmount;

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.PERSIST)
    @JoinColumn(name = "bonus_id")
    private List<Bonus> bonuses;

    @OneToMany(fetch = FetchType.EAGER)
    @JoinColumn(name = "leave_id")
    private List<Leave> leaves;


}


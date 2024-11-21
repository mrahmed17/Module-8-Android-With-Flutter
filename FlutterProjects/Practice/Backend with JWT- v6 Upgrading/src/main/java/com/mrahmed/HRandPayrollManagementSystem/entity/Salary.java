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

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "salary")
    private List<Attendance> overTime;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.PERSIST)
    @JoinColumn(name = "advance_salary_id")
    private AdvanceSalary advanceAmount;

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.PERSIST, mappedBy = "salary")
    private List<Bonus> bonuses;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "salary")
    private List<Leave> leaves;

    // Method to calculate the total salary
    public double calculateTotalSalary() {
        double totalSalary = netSalary;

        // Add bonuses
        for (Bonus bonus : bonuses) {
            totalSalary += bonus.getBonusAmount();
        }

        // Deduct advance salary if paid
        if (advanceAmount != null && advanceAmount.isPaid()) {
            totalSalary -= advanceAmount.getAdvanceAmount();
        }

        // Add overtime
        for (Attendance attendance : overTime) {
            totalSalary += attendance.getOvertimeHours() * 100; // Assuming 100 is the hourly rate
        }

        // Calculate leave deductions and additions (Paid leave adds, Unpaid leave deducts)
        for (Leave leave : leaves) {
            if (leave.getLeaveType() == LeaveType.SICK) {
                totalSalary += leave.getDuration() * 100; // Assuming 100 is the daily wage for paid leaves
            } else if (leave.getLeaveType() == LeaveType.UNPAID) {
                totalSalary -= leave.getDuration() * 100; // Assuming 100 is the daily wage for unpaid leaves
            }
        }

        return totalSalary;
    }

}


package com.mrahmed.HRandPayrollManagementSystem.service;

import com.mrahmed.HRandPayrollManagementSystem.entity.*;
import com.mrahmed.HRandPayrollManagementSystem.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class SalaryService {

    @Autowired
    private SalaryRepository salaryRepository;

    @Autowired
    private AttendanceRepository attendanceRepository;

    @Autowired
    private BonusRepository bonusRepository;

    @Autowired
    private LeaveRepository leaveRepository;

    @Autowired
    private AdvanceSalaryRepository advanceSalaryRepository;

    public Salary saveSalary(Salary salary) {
        return salaryRepository.save(salary);
    }

    public double calculateSalary(long userId) {
        double baseSalary = salaryRepository.findFirstByUserIdOrderByPaymentDateDesc(userId)
                .map(Salary::getUser)
                .map(User::getBasicSalary)
                .orElseThrow(() -> new RuntimeException("Base salary not found for user ID: " + userId));

        double overtimePay = calculateOvertimePay(userId);
        double bonuses = calculateBonuses(userId);
        double advanceDeduction = calculateAdvanceDeduction(userId);
        double leaveDeductions = calculateLeaveDeductions(userId, baseSalary);

        double providentFund = baseSalary * 0.02;
        double tax = baseSalary * 0.05;

        double netSalary = baseSalary + overtimePay + bonuses - advanceDeduction - leaveDeductions - providentFund - tax;
        return netSalary;
    }

    private double calculateOvertimePay(long userId) {
        return attendanceRepository.findAttendancesWithClockOutByUserId(userId).stream()
                .mapToDouble(this::calculateOvertimePayForAttendance)
                .sum();
    }

    private double calculateOvertimePayForAttendance(Attendance attendance) {
        double hourlyRate = attendance.getUser().getBasicSalary() / (4 * 5 * 8); // Monthly rate divided by work hours.
        Duration duration = Duration.between(attendance.getClockInTime(), attendance.getClockOutTime());
        long overtimeHours = Math.max(0, duration.toHours() - 8);
        return overtimeHours * hourlyRate;
    }

    private double calculateBonuses(long userId) {
        return bonusRepository.findBonusesByUserId(userId).stream()
                .mapToDouble(Bonus::getBonusAmount)
                .sum();
    }

    private double calculateAdvanceDeduction(long userId) {
        return advanceSalaryRepository.findByUserIdAndStatus(userId, RequestStatus.APPROVED)
                .map(AdvanceSalary::getAdvanceAmount)
                .orElse(0.0);
    }

    private double calculateLeaveDeductions(long userId, double baseSalary) {
        double dailyRate = baseSalary / 30;
        return leaveRepository.findLeavesByUserId(userId).stream()
                .mapToDouble(leave -> {
                    long days = Duration.between(leave.getStartDate().atStartOfDay(), leave.getEndDate().atStartOfDay())
                            .toDays();
                    return days * dailyRate;
                })
                .sum();
    }

    // Get salary by ID
    public Optional<Salary> getSalaryById(Long id) {
        return salaryRepository.findById(id);
    }

    // Get all salaries
    public List<Salary> getAllSalaries() {
        return salaryRepository.findAll();
    }

    // Update salary
    public Salary updateSalary(Long id, Salary salary) {
        if (!salaryRepository.existsById(id)) {
            throw new RuntimeException("Salary not found with ID: " + id);
        }
        salary.setId(id);
        return salaryRepository.save(salary);
    }

    // Delete salary
    public void deleteSalary(Long id) {
        salaryRepository.deleteById(id);
    }

    // Get salaries by status
    public List<Salary> getSalariesByStatus(RequestStatus status) {
        return salaryRepository.findBySalaryStatus(status);
    }

}

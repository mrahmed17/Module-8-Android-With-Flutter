package com.mrahmed.HRandPayrollManagementSystem.service;

import com.mrahmed.HRandPayrollManagementSystem.entity.*;
import com.mrahmed.HRandPayrollManagementSystem.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class PaySlipService {

    @Autowired
    private SalaryRepository salaryRepository;

    @Autowired
    private BonusRepository bonusRepository;

    @Autowired
    private LeaveRepository leaveRepository;

    @Autowired
    private AttendanceRepository attendanceRepository;

    @Autowired
    private UserRepository userRepository;

    // Method to generate payslip for an employee
    public String generatePaySlip(long userId) {
        // Fetch the Salary for the User
        Optional<Salary> salaryOpt = salaryRepository.findByUserId(userId);
        if (salaryOpt.isEmpty()) {
            return "Salary record not found for user with ID: " + userId;
        }
        Salary salary = salaryOpt.get();

        // Fetch bonuses for the User
        List<Bonus> bonuses = bonusRepository.findBySalaryId(salary.getId());

        // Fetch leaves for the User
        List<Leave> leaves = leaveRepository.findBySalaryId(salary.getId());

        // Fetch attendance details for overtime calculation
        List<Attendance> overtimeRecords = attendanceRepository.findBySalaryId(salary.getId());

        // Calculate total bonus amount
        double totalBonus = bonuses.stream().mapToDouble(Bonus::getBonusAmount).sum();

        // Calculate total leaves and deduct from salary
        int totalLeaveDays = leaves.stream().mapToInt(leave -> leave.getEndDate().getDayOfYear() - leave.getStartDate().getDayOfYear()).sum();
        double leaveDeduction = totalLeaveDays * salary.getNetSalary() / 30; // Assuming net salary is monthly

        // Calculate overtime (example: assuming overtime is added as additional pay)
        double totalOvertime = overtimeRecords.stream().filter(Attendance::isLateCheckIn).mapToDouble(attendance -> 10).sum(); // Just a placeholder calculation

        // Construct payslip content
        StringBuilder paySlip = new StringBuilder();
        paySlip.append("=== Payslip for ").append(salary.getUser().getName()).append(" ===\n");
        paySlip.append("Employee ID: ").append(salary.getUser().getId()).append("\n");
        paySlip.append("Basic Salary: ").append(salary.getNetSalary()).append("\n");
        paySlip.append("Bonus: ").append(totalBonus).append("\n");
        paySlip.append("Leave Deduction: ").append(leaveDeduction).append("\n");
        paySlip.append("Overtime: ").append(totalOvertime).append("\n");
        paySlip.append("Tax Deduction: ").append(salary.getTax()).append("\n");
        paySlip.append("Provident Fund Deduction: ").append(salary.getProvidentFund()).append("\n");
        paySlip.append("Net Salary: ").append(salary.getNetSalary() + totalBonus - leaveDeduction + totalOvertime - salary.getTax() - salary.getProvidentFund()).append("\n");
        paySlip.append("=====================================\n");

        return paySlip.toString();
    }

    public Map<String, Object> getUserPayslipData(long userId) {
        Map<String, Object> response = new HashMap<>();

        // Fetch user details
        Optional<User> userOpt = userRepository.findById(userId);
        if (userOpt.isEmpty()) {
            throw new RuntimeException("User not found with ID: " + userId);
        }
        User user = userOpt.get();
        response.put("user", user);

        // Fetch salary details
        Optional<Salary> salaryOpt = salaryRepository.findByUserId(userId);
        if (salaryOpt.isPresent()) {
            Salary salary = salaryOpt.get();
            response.put("salary", salary);

            // Fetch related bonuses, leaves, and attendance (overtime)
            response.put("bonuses", bonusRepository.findBySalaryId(salary.getId()));
            response.put("leaves", leaveRepository.findBySalaryId(salary.getId()));
            response.put("overtime", attendanceRepository.findBySalaryId(salary.getId()));
        } else {
            response.put("salary", null);
            response.put("bonuses", List.of());
            response.put("leaves", List.of());
            response.put("overtime", List.of());
        }

        return response;
    }



}
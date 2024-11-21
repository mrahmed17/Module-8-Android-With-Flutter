package com.mrahmed.HRandPayrollManagementSystem.service;

import com.mrahmed.HRandPayrollManagementSystem.entity.*;
import com.mrahmed.HRandPayrollManagementSystem.repository.LeaveRepository;
import com.mrahmed.HRandPayrollManagementSystem.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class LeaveService {


    @Autowired
    private LeaveRepository leaveRepository;

    @Autowired
    private UserRepository userRepository;

    public Leave applyLeave(Long userId, LeaveType leaveType, String reason, LocalDate startDate, LocalDate endDate) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with ID: " + userId));

        int duration = calculateLeaveDuration(startDate, endDate);
        Map<LeaveType, Integer> leaveBalance = user.getLeaveBalance();
        int remainingDays = leaveBalance.getOrDefault(leaveType, 0);

        if (leaveType == LeaveType.UNPAID || remainingDays < duration) {
            if (remainingDays < duration) {
                throw new IllegalArgumentException("Insufficient leave balance for " + leaveType);
            }
            double salaryDeduction = calculateSalaryDeduction(user, duration - remainingDays);
            user.setBasicSalary(user.getBasicSalary() - salaryDeduction);
            leaveBalance.put(leaveType, 0);
        } else {
            leaveBalance.put(leaveType, remainingDays - duration);
        }

        Leave leave = new Leave();
        leave.setUser(user);
        leave.setLeaveType(leaveType);
        leave.setReason(reason);
        leave.setStartDate(startDate);
        leave.setEndDate(endDate);
        leave.setRequestStatus(RequestStatus.PENDING);

        userRepository.save(user);
        return leaveRepository.save(leave);
    }

    private int calculateLeaveDuration(LocalDate startDate, LocalDate endDate) {
        if (startDate.isAfter(endDate)) {
            throw new IllegalArgumentException("Start date cannot be after end date.");
        }
        return (int) (endDate.toEpochDay() - startDate.toEpochDay()) + 1;
    }

    private double calculateSalaryDeduction(User user, int unpaidDays) {
        return unpaidDays * (user.getBasicSalary() / 30.0); // Assuming a 30-day month
    }

//    public Leave applyLeave(Long userId, Leave leaveRequest) {
//        User user = userRepository.findById(userId)
//                .orElseThrow(() -> new RuntimeException("User not found"));
//        int duration = calculateDuration(leaveRequest.getStartDate(), leaveRequest.getEndDate());
//        validateLeaveBalance(user, leaveRequest.getLeaveType(), duration);
//
//        leaveRequest.setUser(user);
//        leaveRequest.setDuration(duration);
//        leaveRequest.setRequestStatus(RequestStatus.PENDING);
//        leaveRequest.setRequestDate(LocalDateTime.now());
//        return leaveRepository.save(leaveRequest);
//    }

    public Leave updateLeave(Long id, Leave updatedLeave) {
        Leave existingLeave = leaveRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Leave not found"));
        existingLeave.setStartDate(updatedLeave.getStartDate());
        existingLeave.setEndDate(updatedLeave.getEndDate());
        existingLeave.setReason(updatedLeave.getReason());
        existingLeave.setLeaveType(updatedLeave.getLeaveType());
        existingLeave.setRequestStatus(updatedLeave.getRequestStatus());
        return leaveRepository.save(existingLeave);
    }

    public void deleteLeave(Long leaveId) {
        leaveRepository.deleteById(leaveId);
    }

    public Leave approveLeave(Long leaveId) {
        Leave leave = findLeaveOrThrow(leaveId);
        leave.setRequestStatus(RequestStatus.APPROVED);
        return leaveRepository.save(leave);
    }

    public Leave rejectLeave(Long leaveId) {
        Leave leave = findLeaveOrThrow(leaveId);
        leave.setRequestStatus(RequestStatus.REJECTED);
        return leaveRepository.save(leave);
    }

    public List<Leave> getUserLeaves(Long userId) {
        return leaveRepository.findByUserIdAndRequestStatus(userId, RequestStatus.APPROVED);
    }

    private int calculateDuration(LocalDate startDate, LocalDate endDate) {
        if (startDate.isAfter(endDate)) {
            throw new IllegalArgumentException("Start date cannot be after end date");
        }
        return (int) (endDate.toEpochDay() - startDate.toEpochDay()) + 1;
    }

    private void validateLeaveBalance(User user, LeaveType leaveType, int duration) {
        // Logic for checking leave balance
    }

    private Leave findLeaveOrThrow(Long leaveId) {
        return leaveRepository.findById(leaveId)
                .orElseThrow(() -> new RuntimeException("Leave not found"));
    }
}

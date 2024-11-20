package com.mrahmed.HRandPayrollManagementSystem.service;

import com.mrahmed.HRandPayrollManagementSystem.entity.Leave;
import com.mrahmed.HRandPayrollManagementSystem.entity.LeaveType;
import com.mrahmed.HRandPayrollManagementSystem.entity.RequestStatus;
import com.mrahmed.HRandPayrollManagementSystem.entity.User;
import com.mrahmed.HRandPayrollManagementSystem.repository.LeaveRepository;
import com.mrahmed.HRandPayrollManagementSystem.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class LeaveService {

    @Autowired
    private LeaveRepository leaveRepository;
    @Autowired
    private UserRepository userRepository;

    public boolean applyLeave(User user, LeaveType leaveType, int requestedDays) {
        Map<LeaveType, Integer> leaveBalance = user.getLeaveBalance();
        int remainingDays = leaveBalance.getOrDefault(leaveType, 0);

        if (leaveType == LeaveType.UNPAID) {
            double deduction = calculateSalaryDeduction(user, requestedDays);
            user.setBasicSalary(user.getBasicSalary() - deduction);
            return true;
        }

        if (remainingDays >= requestedDays) {
            leaveBalance.put(leaveType, remainingDays - requestedDays);
            userRepository.save(user);
            return true;
        }

        throw new IllegalArgumentException("Not enough " + leaveType + " leave available.");
    }

    //  update leave request
    public Leave updateLeaveRequest(Long id, Leave updatedLeave) {
        Leave existingLeave = leaveRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Leave request not found with ID: " + id));
        validateLeaveDates(updatedLeave.getStartDate(), updatedLeave.getEndDate());

        existingLeave.setStartDate(updatedLeave.getStartDate());
        existingLeave.setEndDate(updatedLeave.getEndDate());
        existingLeave.setRequestDate(updatedLeave.getRequestDate());
        existingLeave.setReason(updatedLeave.getReason());
        existingLeave.setLeaveType(updatedLeave.getLeaveType());
        existingLeave.setRequestStatus(updatedLeave.getRequestStatus());
        return leaveRepository.save(existingLeave);
    }


    // Delete leave by ID
    public void deleteLeave(Long leaveId) {
        leaveRepository.deleteById(leaveId);
    }

    public Leave approveLeaveRequest(Long leaveId) {
        Leave leave = getLeaveOrThrow(leaveId);
        leave.setRequestStatus(RequestStatus.APPROVED);
        return leaveRepository.save(leave);
    }

    public Leave rejectLeaveRequest(Long leaveId) {
        Leave leave = getLeaveOrThrow(leaveId);
        leave.setRequestStatus(RequestStatus.REJECTED);
        return leaveRepository.save(leave);
    }

    @Scheduled(cron = "0 0 0 1 1 *") // At midnight on January 1st every year
    public void resetLeaveBalances() {
        List<User> users = userRepository.findAll();
        for (User user : users) {
            user.getLeaveBalance().put(LeaveType.SICK, 15);
            user.getLeaveBalance().put(LeaveType.RESERVE, 10);
            userRepository.save(user);
        }
    }

    // Find leave by ID
    public Optional<Leave> getLeaveById(Long leaveId) {
        return leaveRepository.findById(leaveId);
    }

    public List<Leave> getPendingLeaveRequests() {
        return leaveRepository.findPendingLeaveRequests();
    }

    public List<Leave> getRejectedLeaveRequests() {
        return leaveRepository.findRejectedLeaveRequests();
    }

    public List<Leave> getApprovedLeavesByUser(Long userId) {
        return leaveRepository.findApprovedLeavesByUser(userId);
    }

    public List<Leave> getLeavesByType(LeaveType leaveType) {
        return leaveRepository.findLeavesByType(leaveType);
    }

    public List<Leave> getLeavesByUserAndDateRange(Long userId, LocalDate startDate, LocalDate endDate) {
        validateLeaveDates(startDate, endDate);
        return leaveRepository.findLeavesByUserAndDateRange(userId, startDate, endDate);
    }

    public List<Leave> getLeavesByReason(String reason) {
        return leaveRepository.findLeavesByReason(reason);
    }

    private int calculateRemainingLeaveDays(LocalDate startDate, LocalDate endDate) {
        return (int) (endDate.toEpochDay() - startDate.toEpochDay()) + 1;
    }

    private double calculateSalaryDeduction(User user, int requestedDays) {
        return requestedDays * (user.getBasicSalary() / 30); // Assuming 30 days in a month
    }

    private void validateLeaveDates(LocalDate startDate, LocalDate endDate) {
        if (startDate.isAfter(endDate)) {
            throw new IllegalArgumentException("Start date cannot be after end date.");
        }
    }

    private Leave getLeaveOrThrow(Long leaveId) {
        return leaveRepository.findById(leaveId)
                .orElseThrow(() -> new RuntimeException("Leave request not found with ID: " + leaveId));
    }

}

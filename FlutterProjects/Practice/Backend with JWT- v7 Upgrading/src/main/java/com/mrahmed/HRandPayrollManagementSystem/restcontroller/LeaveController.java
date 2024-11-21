package com.mrahmed.HRandPayrollManagementSystem.restcontroller;

import com.mrahmed.HRandPayrollManagementSystem.entity.Bonus;
import com.mrahmed.HRandPayrollManagementSystem.entity.Leave;
import com.mrahmed.HRandPayrollManagementSystem.entity.LeaveType;
import com.mrahmed.HRandPayrollManagementSystem.entity.User;
import com.mrahmed.HRandPayrollManagementSystem.service.LeaveService;
import com.mrahmed.HRandPayrollManagementSystem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/leaves")
@CrossOrigin("*")
public class LeaveController {

    @Autowired
    private LeaveService leaveService;

    @PostMapping("/apply/{userId}")
    public ResponseEntity<Leave> applyLeave(@PathVariable Long userId, @RequestBody Leave leaveRequest) {
        if (leaveRequest.getStartDate() == null || leaveRequest.getEndDate() == null) {
            throw new IllegalArgumentException("Start date and end date must be provided.");
        }
        if (leaveRequest.getStartDate().isAfter(leaveRequest.getEndDate())) {
            throw new IllegalArgumentException("Start date cannot be after end date.");
        }

        Leave leave = leaveService.applyLeave(
                userId,
                leaveRequest.getLeaveType(),
                leaveRequest.getReason(),
                leaveRequest.getStartDate(),
                leaveRequest.getEndDate()
        );
        return ResponseEntity.ok(leave);
    }


    @PutMapping("/update/{id}")
    public ResponseEntity<Leave> updateLeave(@PathVariable Long id, @RequestBody Leave leave) {
        return ResponseEntity.ok(leaveService.updateLeave(id, leave));
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteLeave(@PathVariable Long id) {
        leaveService.deleteLeave(id);
        return ResponseEntity.ok("Leave deleted successfully");
    }

    @PatchMapping("/{id}/approve")
    public ResponseEntity<Leave> approveLeave(@PathVariable Long id) {
        return ResponseEntity.ok(leaveService.approveLeave(id));
    }

    @PatchMapping("/{id}/reject")
    public ResponseEntity<Leave> rejectLeave(@PathVariable Long id) {
        return ResponseEntity.ok(leaveService.rejectLeave(id));
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<List<Leave>> getUserLeaves(@PathVariable Long userId) {
        return ResponseEntity.ok(leaveService.getUserLeaves(userId));
    }
}

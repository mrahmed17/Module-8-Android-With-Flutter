package com.mrahmed.HRandPayrollManagementSystem.restcontroller;

import com.mrahmed.HRandPayrollManagementSystem.entity.AdvanceSalary;
import com.mrahmed.HRandPayrollManagementSystem.service.AdvanceSalaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/advanceSalaries")
@CrossOrigin("*")
public class AdvanceSalaryRestController {

    @Autowired
    private AdvanceSalaryService advanceSalaryService;

    // Create a new advance salary record
    @PostMapping("/create")
    public ResponseEntity<?> createAdvanceSalary(@RequestBody AdvanceSalary advanceSalary) {
        try {
            AdvanceSalary savedAdvanceSalary = advanceSalaryService.saveAdvanceSalary(advanceSalary);
            return ResponseEntity.ok(savedAdvanceSalary);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An unexpected error occurred");
        }
    }

    // Update an existing advance salary record
    @PutMapping("/update/{id}")
    public ResponseEntity<?> updateAdvanceSalary(@PathVariable Long id, @RequestBody AdvanceSalary advanceSalary) {
        try {
            advanceSalary.setId(id);
            AdvanceSalary updatedAdvanceSalary = advanceSalaryService.updateAdvanceSalary(advanceSalary);
            return ResponseEntity.ok(updatedAdvanceSalary);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Advance salary record not found.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to update advance salary: " + e.getMessage());
        }
    }

    // Delete an advance salary record by ID
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Void> deleteAdvanceSalary(@PathVariable Long id) {
        try {
            advanceSalaryService.deleteAdvanceSalary(id);
            return ResponseEntity.noContent().build();
        } catch (IllegalArgumentException e) {
            return ResponseEntity.notFound().build(); // Return not found if ID doesn't exist
        }
    }
    // Get an advance salary record by ID
    @GetMapping("/find/{id}")
    public ResponseEntity<AdvanceSalary> getAdvanceSalaryById(@PathVariable Long id) {
        try {
            AdvanceSalary advanceSalary = advanceSalaryService.getAdvanceSalaryById(id);
            return ResponseEntity.ok(advanceSalary);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.notFound().build(); // Return not found if ID doesn't exist
        }
    }

    // Get all advance salary records for a specific user ID
    @GetMapping("/user/{userId}")
    public ResponseEntity<List<AdvanceSalary>> getAllByUserId(@PathVariable Long userId) {
        try {
            List<AdvanceSalary> advanceSalaries = advanceSalaryService.findAllByUserId(userId);
            return ResponseEntity.ok(advanceSalaries);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(null); // Handle the error gracefully
        }
    }

    // Get advance salaries within a specific date range
    @GetMapping("/date-range")
    public ResponseEntity<List<AdvanceSalary>> getAdvanceSalariesByDateRange(
            @RequestParam LocalDateTime startDate,
            @RequestParam LocalDateTime endDate) {
        List<AdvanceSalary> advanceSalaries = advanceSalaryService.getAdvanceSalariesByDateRange(startDate, endDate);
        return ResponseEntity.ok(advanceSalaries);
    }

    // Get the latest advance salary record for a user
    @GetMapping("/topAdvanceTaker/user/{userId}")
    public ResponseEntity<List<AdvanceSalary>> findTop5ByUserIdOrderByAdvanceDateDesc(@PathVariable Long userId) {
        List<AdvanceSalary> latestAdvanceSalaries = advanceSalaryService.findTop5ByUserIdOrderByAdvanceDateDesc(userId);
        return ResponseEntity.ok(latestAdvanceSalaries);
    }

    // Get pending salary requests
    @GetMapping("/pending")
    public ResponseEntity<List<AdvanceSalary>> getPendingSalaryRequests() {
        List<AdvanceSalary> pendingSalaries = advanceSalaryService.getPendingSalaryRequests();
        return ResponseEntity.ok(pendingSalaries);
    }

    // Get rejected salary requests
    @GetMapping("/rejected")
    public ResponseEntity<List<AdvanceSalary>> getRejectedSalaryRequests() {
        List<AdvanceSalary> rejectedSalaries = advanceSalaryService.getRejectedSalaryRequests();
        return ResponseEntity.ok(rejectedSalaries);
    }

    // Get approved salary records for a specific user
    @GetMapping("/approved/user/{userId}")
    public ResponseEntity<List<AdvanceSalary>> getApprovedSalaryByUser (@PathVariable Long userId) {
        List<AdvanceSalary> approvedSalaries = advanceSalaryService.getApprovedSalaryByUser (userId);
        return ResponseEntity.ok(approvedSalaries);
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<List<AdvanceSalary>> getAdvanceSalaryByUserAndDateRange(
            @PathVariable Long userId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate) {

        List<AdvanceSalary> advanceSalaries =
                advanceSalaryService.getAdvanceSalaryByUserAndDateRange(userId, startDate, endDate);
        return ResponseEntity.ok(advanceSalaries);
    }

}

package com.mrahmed.HRandPayrollManagementSystem.restcontroller;

import com.mrahmed.HRandPayrollManagementSystem.entity.User;
import com.mrahmed.HRandPayrollManagementSystem.service.UserService;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDate;

@RestController
@AllArgsConstructor
@CrossOrigin("*")
@RequestMapping("/api/auth")
public class UserController {

    private final UserService userService;

    // ===== User Management Endpoints =====

    @GetMapping("/find/{id}")
    public ResponseEntity<User> findUserById(@PathVariable Long id) {
        try {
            User user = userService.findUserById(id);
            return ResponseEntity.ok(user);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<String> updateUser(
            @PathVariable Long id,
            @RequestPart("user") User user,
            @RequestPart(value = "profilePhoto", required = false) MultipartFile profilePhoto) {
        try {
            userService.updateUser(id, user, profilePhoto);
            return ResponseEntity.ok("User updated successfully.");
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to update user: " + e.getMessage());
        }
    }

    @GetMapping("/getAllManagers")
    public ResponseEntity<Page<User>> getAllManagers(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        Page<User> managers = userService.getAllManagers(PageRequest.of(page, size));
        return ResponseEntity.ok(managers);
    }

    @GetMapping("/getAllEmployees")
    public ResponseEntity<Page<User>> getAllEmployees(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        Page<User> employees = userService.getAllEmployees(PageRequest.of(page, size));
        return ResponseEntity.ok(employees);
    }

    @GetMapping("/searchUsersByName")
    public ResponseEntity<Page<User>> searchUsersByName(
            @RequestParam String name,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        Page<User> users = userService.searchUsersByName(name, PageRequest.of(page, size));
        return ResponseEntity.ok(users);
    }

    @GetMapping("/salary/greaterThanOrEqual")
    public ResponseEntity<Page<User>> getUsersWithSalaryGreaterThanOrEqual(
            @RequestParam double salary,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size
    ) {
        Page<User> users = userService.getUsersWithSalaryGreaterThanOrEqual(salary, PageRequest.of(page, size));
        return ResponseEntity.ok(users);
    }

    @GetMapping("/salary/lessThanOrEqual")
    public ResponseEntity<Page<User>> getUsersWithSalaryLessThanOrEqual(
            @RequestParam double salary,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size
    ) {
        Page<User> users = userService.getUsersWithSalaryLessThanOrEqual(salary, PageRequest.of(page, size));
        return ResponseEntity.ok(users);
    }

    @GetMapping("/getUsersByGender")
    public ResponseEntity<Page<User>> getUsersByGender(
            @RequestParam String gender,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size
    ) {
        Page<User> users = userService.getUsersByGender(gender, PageRequest.of(page, size));
        return ResponseEntity.ok(users);
    }

    @GetMapping("/getUsersByJoinedDate")
    public ResponseEntity<Page<User>> getUsersByJoinedDate(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate joinedDate,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size
    ) {
        Page<User> users = userService.getUsersByJoinedDate(joinedDate, PageRequest.of(page, size));
        return ResponseEntity.ok(users);
    }

}

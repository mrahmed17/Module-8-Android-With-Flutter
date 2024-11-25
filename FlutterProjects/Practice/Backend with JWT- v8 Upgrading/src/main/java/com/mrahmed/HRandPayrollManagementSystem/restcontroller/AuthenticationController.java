package com.mrahmed.HRandPayrollManagementSystem.restcontroller;

import com.mrahmed.HRandPayrollManagementSystem.entity.AuthenticationResponse;
import com.mrahmed.HRandPayrollManagementSystem.entity.Role;
import com.mrahmed.HRandPayrollManagementSystem.entity.User;
import com.mrahmed.HRandPayrollManagementSystem.service.AuthService;
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
public class AuthenticationController {

    private final AuthService authService;
    private final UserService userService;

    // ===== Registration Endpoints =====

    @PostMapping("/register/admin")
    public ResponseEntity<AuthenticationResponse> registerAdmin(
            @RequestPart User user,
            @RequestPart(required = false) MultipartFile profilePhoto) {
        return handleRegistration(user, Role.ADMIN, profilePhoto);
    }

    @PostMapping("/register/manager")
    public ResponseEntity<AuthenticationResponse> registerManager(
            @RequestPart User user,
            @RequestPart(required = false) MultipartFile profilePhoto) {
        return handleRegistration(user, Role.MANAGER, profilePhoto);
    }

    @PostMapping("/register/employee")
    public ResponseEntity<AuthenticationResponse> registerEmployee(
            @RequestPart User user,
            @RequestPart(required = false) MultipartFile profilePhoto) {
        return handleRegistration(user, Role.EMPLOYEE, profilePhoto);
    }

    private ResponseEntity<AuthenticationResponse> handleRegistration(User user, Role role, MultipartFile profilePhoto) {
        try {
            AuthenticationResponse response = authService.registerUser(user, role, profilePhoto);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new AuthenticationResponse("Registration error: " + e.getMessage()));
        }
    }

    // ===== Authentication Endpoints =====

    @PostMapping("/login")
    public ResponseEntity<AuthenticationResponse> login(@RequestBody User request) {
        AuthenticationResponse response = authService.authenticate(request);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/activate/{id}")
    public ResponseEntity<String> activateUser(@PathVariable("id") long id) {
        String response = authService.activateUser(id);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/forgot-password")
    public ResponseEntity<String> forgotPassword(@RequestParam String email) {
        authService.forgotPassword(email);
        return ResponseEntity.ok("Password reset link sent to email.");
    }

    @PostMapping("/reset-password")
    public ResponseEntity<String> resetPassword(
            @RequestParam String token,
            @RequestParam String newPassword) {
        String response = authService.resetPassword(token, newPassword);
        return ResponseEntity.ok(response);
    }


}

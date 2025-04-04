package com.mrahmed.HRandPayrollManagementSystem.service;

import com.mrahmed.HRandPayrollManagementSystem.entity.*;
import com.mrahmed.HRandPayrollManagementSystem.jwt.JwtService;
import com.mrahmed.HRandPayrollManagementSystem.repository.PasswordResetTokenRepository;
import com.mrahmed.HRandPayrollManagementSystem.repository.TokenRepository;
import com.mrahmed.HRandPayrollManagementSystem.repository.UserRepository;
import com.mrahmed.HRandPayrollManagementSystem.util.EmailContentBuilder;
import jakarta.mail.MessagingException;
import lombok.AllArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.time.LocalDateTime;

@Service
@AllArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final TokenRepository tokenRepository;
    private final AuthenticationManager authenticationManager;
    private final PasswordResetTokenRepository passwordResetTokenRepository;
    private final EmailService emailService;
    private final UserService userService;


    private void saveUserToken(String jwt, User user) {
        Token token = new Token();
        token.setToken(jwt);
        token.setLoggedOut(false);
        token.setUser(user);
        tokenRepository.save(token);
    }

    private void revokeAllTokenByUser(User user) {
        List<Token> validTokens = tokenRepository.findAllTokensByUser(user.getId());
        if (validTokens.isEmpty()) {
            return;
        }
        // Set all valid tokens for the user to logged out
        validTokens.forEach(t -> {
            t.setLoggedOut(true);
        });

        // Save the changes to the tokens in the token repository
        tokenRepository.saveAll(validTokens);
    }

    public void revokeToken(String token) {
        Token existingToken = tokenRepository.findByToken(token)
                .orElseThrow(() -> new RuntimeException("Token not found"));
        existingToken.setLoggedOut(true);
        tokenRepository.save(existingToken);
    }


    // One method for all roles registration
    public AuthenticationResponse registerEmployee(User user, MultipartFile profilePhoto) throws IOException {
        if (userRepository.findByEmail(user.getUsername()).isPresent()) {
            return new AuthenticationResponse(null,  "Employee already exists", null);
        }

        if (profilePhoto != null && !profilePhoto.isEmpty()) {
            String profilePhotoPath = userService.saveProfileImage(profilePhoto, user.getName());
            user.setProfilePhoto(profilePhotoPath);
        }

        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(Role.valueOf("EMPLOYEE"));
        user.setActive(false);

        // Set default leave balance (e.g., 25 days total. On these days 15 days sick and 10 days reserve for a year leave types)
        Map<LeaveType, Integer> defaultLeaveBalance = new HashMap<>();
        defaultLeaveBalance.put(LeaveType.SICK, 15);
        defaultLeaveBalance.put(LeaveType.UNPAID, 30);
        defaultLeaveBalance.put(LeaveType.RESERVE, 10);
        user.setLeaveBalance(defaultLeaveBalance);

        userRepository.save(user);

        String jwt = jwtService.generateToken(user);
        saveUserToken(jwt, user);
        sendActivationEmail(user);

        return new AuthenticationResponse(jwt, "Employee registration is successful", null);
    }

    public AuthenticationResponse registerAdmin(User user, MultipartFile profilePhoto) throws IOException {
        if (userRepository.findByEmail(user.getUsername()).isPresent()) {
            return new AuthenticationResponse(null, "Admin already exists", null);
        }

        if (profilePhoto != null && !profilePhoto.isEmpty()) {
            String profilePhotoPath = userService.saveProfileImage(profilePhoto, user.getName());
            user.setProfilePhoto(profilePhotoPath);
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(Role.valueOf("ADMIN"));
        user.setLock(false);
        user.setActive(true);
        userRepository.save(user);
        String jwt = jwtService.generateToken(user);
        saveUserToken(jwt, user);

        return new AuthenticationResponse(jwt, "Admin registration is successful", null);
    }

    public AuthenticationResponse registerManager(User user, MultipartFile profilePhoto) throws IOException {
        if (userRepository.findByEmail(user.getUsername()).isPresent()) {
            return new AuthenticationResponse(null, "Manager already exists", null);
        }

        if (profilePhoto != null && !profilePhoto.isEmpty()) {
            String profilePhotoPath = userService.saveProfileImage(profilePhoto, user.getName());
            user.setProfilePhoto(profilePhotoPath);
        }

        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(Role.valueOf("MANAGER"));
        user.setLock(false);
        user.setActive(true);
        userRepository.save(user);
        String jwt = jwtService.generateToken(user);
        saveUserToken(jwt, user);

        return new AuthenticationResponse(jwt, "Manager registration is successful", null);
    }

    // Method to authenticate a user
    public AuthenticationResponse authenticate(User request) {

        // Authenticate user credentials using Spring Security's AuthenticationManager
        authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(request.getUsername(), request.getPassword()));

        // Retrieve the user from the database
        User user = userRepository.findByEmail(request.getUsername()).orElseThrow();

        // Generate JWT token for the authenticated user
        String jwt = jwtService.generateToken(user);

        // Revoke all existing tokens for this user
        revokeAllTokenByUser(user);

        // Save the new token to the token repository
        saveUserToken(jwt, user);

        return new AuthenticationResponse(jwt, "Login is successful", user);
    }

    // Mail text are store to EmailContentBuilder helper class and then implement it
    private void sendActivationEmail(User user) {
        String activationLink = "http://localhost:8080/activate/" + user.getId();
        String mailText = EmailContentBuilder.buildActivationEmail(user.getName(), activationLink);
        String subject = "Activate Your Account – IsDB Scholarship Program";

        try {
            emailService.sendHtmlEmail(user.getEmail(), subject, mailText);
        } catch (MessagingException e) {
            throw new RuntimeException("Failed to send activation email", e);
        }
    }


    // Activate user based on the token
    public String activateUser(long id) {

        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not Found with this ID" + id));

        if (user != null) {
            user.setActive(true);
            //  user.setActivationToken(null); // Clear token after activation
            userRepository.save(user);
            return "Activation successfully!";
        } else {
            return "Invalid activation token!";
        }
    }


    public void forgotPassword(String email) {
        // Find user by email
        User user = userRepository.findByEmail(email).orElseThrow(() -> new RuntimeException("User not found"));

        // Generate a reset token
        String token = UUID.randomUUID().toString();
        LocalDateTime expiryDate = LocalDateTime.now().plusHours(1); // 1-hour expiration

        // Save reset token to the database
        PasswordResetToken resetToken = new PasswordResetToken();
        resetToken.setToken(token);
        resetToken.setUser(user);
        resetToken.setExpiryDate(expiryDate);
        passwordResetTokenRepository.save(resetToken);

        // Send reset email
        String resetLink = "http://localhost:8080/reset-password?token=" + token;
        String emailContent = "Click the link to reset your password: " + resetLink;

        try {
            emailService.sendSimpleEmail(user.getEmail(), "Password Reset Request", emailContent);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    public String resetPassword(String token, String newPassword) {
        PasswordResetToken resetToken = passwordResetTokenRepository.findByToken(token)
                .orElseThrow(() -> new RuntimeException("Invalid token"));

        if (resetToken.getExpiryDate().isBefore(LocalDateTime.now())) {
            throw new RuntimeException("Token expired");
        }

        User user = resetToken.getUser();
        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);

        passwordResetTokenRepository.delete(resetToken); // Remove token after reset
        return "Password reset successful";
    }


}

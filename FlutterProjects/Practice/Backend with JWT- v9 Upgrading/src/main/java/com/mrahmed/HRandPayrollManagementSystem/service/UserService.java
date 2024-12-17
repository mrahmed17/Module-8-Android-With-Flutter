package com.mrahmed.HRandPayrollManagementSystem.service;

import com.mrahmed.HRandPayrollManagementSystem.entity.Role;
import com.mrahmed.HRandPayrollManagementSystem.entity.User;
import com.mrahmed.HRandPayrollManagementSystem.repository.UserRepository;
import com.mrahmed.HRandPayrollManagementSystem.util.PhotoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.io.IOException;
import java.util.List;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PhotoService photoService;

    // Load user by username for Spring Security
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepository.findByEmail(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found with this username: " + username));
    }

    public String saveProfileImage(MultipartFile file, String fullName) throws IOException {
        return photoService.savePhoto(file, fullName, "profilePhotos");
    }

    // update registration user
    @Transactional
    public void updateUser(Long id, User updatedUser, MultipartFile profilePhoto) throws IOException {
        User existingUser = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found with ID: " + id));
        existingUser.setName(updatedUser.getName());
        existingUser.setEmail(updatedUser.getEmail());
        existingUser.setAddress(updatedUser.getAddress());
        existingUser.setGender(updatedUser.getGender());
        existingUser.setDateOfBirth(updatedUser.getDateOfBirth());
        existingUser.setCell(updatedUser.getCell());
        existingUser.setBasicSalary(updatedUser.getBasicSalary());
        existingUser.setRole(updatedUser.getRole());
        if (profilePhoto != null && !profilePhoto.isEmpty()) {
            String profilePhotoFilename = saveProfileImage(profilePhoto, updatedUser.getName());
            existingUser.setProfilePhoto(profilePhotoFilename);
        }
        userRepository.save(existingUser);
    }

    public User findUserById(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User Not Found"));
    }

    // Fetch all managers with 
    public List<User> getAllManagers() {
        return userRepository.findAllByRole(Role.MANAGER);
    }

    // Fetch all employees with 
    public List<User> getAllEmployees() {
        return userRepository.findAllByRole(Role.EMPLOYEE);
    }
//
//    // Search users by a partial or full name match
//    public List<User> searchUsersByName(String name ) {
//        return userRepository.findByFullNameContaining(name);
//    }
//
//    // Fetch users by gender with
//    public List<User> getUsersByGender(String gender) {
//        return userRepository.findByGender(gender);
//    }
//
    // Fetch users by gender and name with
    public List<User> getEmployeesByFilters(String name, String gender) {
        return userRepository.findEmployeesByFilters(name, gender);
    }

    // Fetch users by joined date with 
    public List<User> getUsersByJoinedDate(LocalDate joinedDate ) {
        return userRepository.findByJoinedDate(joinedDate);
    }

    // Fetch users with a basic salary greater than or equal to a specified amount
    public List<User> getUsersWithSalaryGreaterThanOrEqual(double salary) {
        return userRepository.findUsersWithSalaryGreaterThanOrEqual(salary);
    }

    // Fetch users with a basic salary less than or equal to a specified amount
    public List<User> getUsersWithSalaryLessThanOrEqual(double salary ) {
        return userRepository.findUsersWithSalaryLessThanOrEqual(salary);
    }


}

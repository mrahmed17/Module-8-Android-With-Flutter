package com.mrahmed.HRandPayrollManagementSystem.restcontroller;

import com.mrahmed.HRandPayrollManagementSystem.entity.AuthenticationResponse;
import com.mrahmed.HRandPayrollManagementSystem.entity.User;
import com.mrahmed.HRandPayrollManagementSystem.service.AuthService;
import com.mrahmed.HRandPayrollManagementSystem.service.UserService;
import lombok.AllArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;


@RestController
@RequestMapping("/api/users")
@AllArgsConstructor
@CrossOrigin("*")
public class UserController {

    private final UserService userService;


    @PutMapping("/update/{id}")
    public ResponseEntity<String> updateUser(@PathVariable Long id, @RequestPart("user") User user, @RequestPart(value = "profilePhoto", required = false) MultipartFile profilePhoto
    ) {
        try {
            userService.updateUser(id, user, profilePhoto);
            return new ResponseEntity<>("User updated successfully.", HttpStatus.OK);
        } catch (IOException e) {
            return new ResponseEntity<>("Failed to update user: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/find/{id}")
    public ResponseEntity<User> findUserById(@PathVariable Long id) {
        try {
            User user = userService.findUserById(id);
            return ResponseEntity.ok(user);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/getAllManagers")
    public ResponseEntity<List<User>> getAllManagers() {
        List<User> managers = userService.getAllManagers();
        return ResponseEntity.ok(managers);
    }

    @GetMapping("/getAllEmployees")
    public ResponseEntity<List<User>> getAllEmployees() {
        List<User> employees = userService.getAllEmployees();
        return ResponseEntity.ok(employees);
    }

    @GetMapping("/filtersByNameGender")
    public ResponseEntity<List<User>> filtersByNameGender(@RequestParam String name, @RequestParam String gender) {
        List<User> users = userService.getEmployeesByFilters(name, gender);
        return ResponseEntity.ok(users);
    }

//    @GetMapping("/searchUsersByName")
//    public ResponseEntity<List<User>> searchUsersByName(@RequestParam String name) {
//        List<User> users = userService.searchUsersByName(name);
//        return ResponseEntity.ok(users);
//    }
//
//    @GetMapping("/getUsersByGender")
//    public ResponseEntity<List<User>> getUsersByGender(@RequestParam String gender) {
//        List<User> users = userService.getUsersByGender(gender);
//        return ResponseEntity.ok(users);
//    }

    @GetMapping("/getUsersByJoinedDate")
    public ResponseEntity<List<User>> getUsersByJoinedDate(@DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate joinedDate) {
        List<User> users = userService.getUsersByJoinedDate(joinedDate);
        return ResponseEntity.ok(users);
    }

    @GetMapping("/salary/greaterThanOrEqual")
    public ResponseEntity<List<User>> getUsersWithSalaryGreaterThanOrEqual(@RequestParam double salary) {
        List<User> users = userService.getUsersWithSalaryGreaterThanOrEqual(salary);
        return ResponseEntity.ok(users);
    }

    @GetMapping("/salary/lessThanOrEqual")
    public ResponseEntity<List<User>> getUsersWithSalaryLessThanOrEqual(@RequestParam double salary) {
        List<User> users = userService.getUsersWithSalaryLessThanOrEqual(salary);
        return ResponseEntity.ok(users);
    }

}

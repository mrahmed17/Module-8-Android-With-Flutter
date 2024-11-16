package com.mrahmed.HRandPayrollManagementSystem.restcontroller;

import com.mrahmed.HRandPayrollManagementSystem.service.AttendanceService;
import com.mrahmed.HRandPayrollManagementSystem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.util.Collections;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/attendance")
@CrossOrigin("*")
public class AttendanceRestController {

    @Autowired
    private AttendanceService attendanceService;

    @Autowired
    private UserService userService;

    @PostMapping("/checkin")
    public ResponseEntity<?> checkIn(@RequestBody Map<String, Object> request) {
        try {
            long userId = Long.parseLong(request.get("userId").toString());
            AttendanceDTO attendance = attendanceService.checkIn(userId);
            return ResponseEntity.status(HttpStatus.CREATED).body(attendance);
        } catch (NumberFormatException e) {
            return ResponseEntity.badRequest().body("Invalid user ID format");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error occurred while checking in: " + e.getMessage());
        }
    }

    @PutMapping("/checkout")
    public ResponseEntity<?> checkOut(@RequestBody Map<String, Object> request) {
        try {
            long userId = Long.parseLong(request.get("userId").toString());
            AttendanceDTO attendance = attendanceService.checkOut(userId);
            return ResponseEntity.ok(attendance);
        } catch (NumberFormatException e) {
            return ResponseEntity.badRequest().body("Invalid user ID format");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error occurred while checking out: " + e.getMessage());
        }
    }

    @GetMapping("/overtime/{userId}")
    public ResponseEntity<List<AttendanceDTO>> getOvertimeByUser(
            @PathVariable Long userId,
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam("endDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        try {
            List<AttendanceDTO> overtimeRecords = attendanceService.getOvertimeForUser(userId, startDate, endDate);
            return overtimeRecords.isEmpty()
                    ? ResponseEntity.noContent().build()
                    : ResponseEntity.ok(overtimeRecords);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.emptyList());
        }
    }

    @GetMapping("/today")
    public ResponseEntity<List<AttendanceDTO>> getTodayAttendance() {
        try {
            List<AttendanceDTO> attendances = attendanceService.getTodayAttendances();
            return attendances.isEmpty()
                    ? ResponseEntity.noContent().build()
                    : ResponseEntity.ok(attendances);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.emptyList());
        }
    }

    @GetMapping("/")
    public ResponseEntity<List<AttendanceDTO>> getAllAttendances() {
        try {
            List<AttendanceDTO> attendances = attendanceService.getAllAttendances();
            return attendances.isEmpty()
                    ? ResponseEntity.noContent().build()
                    : ResponseEntity.ok(attendances);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.emptyList());
        }
    }

    @GetMapping("/find/{id}")
    public ResponseEntity<AttendanceDTO> findAttendanceById(@PathVariable("id") long id) {
        try {
            AttendanceDTO attendance = attendanceService.findAttendanceById(id);
            return attendance == null
                    ? ResponseEntity.status(HttpStatus.NOT_FOUND).build()
                    : ResponseEntity.ok(attendance);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(null);
        }
    }

    @GetMapping("/user/{id}/attendances")
    public ResponseEntity<List<AttendanceDTO>> getAttendancesByUserId(@PathVariable Long id) {
        try {
            List<AttendanceDTO> attendances = attendanceService.getAttendanceByUserId(id);
            return attendances.isEmpty()
                    ? ResponseEntity.noContent().build()
                    : ResponseEntity.ok(attendances);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.emptyList());
        }
    }

    @GetMapping("/attendanceRange")
    public ResponseEntity<Map<UserDTO, Long>> getUsersWithAttendanceInRange(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam("endDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        try {
            Map<UserDTO, Long> userAttendance = attendanceService.getUsersAttendanceInRange(startDate, endDate);
            return userAttendance.isEmpty()
                    ? ResponseEntity.noContent().build()
                    : ResponseEntity.ok(userAttendance);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.emptyMap());
        }
    }


    @GetMapping("/usersWithoutAttendanceToday")
    public ResponseEntity<List<UserDTO>> getUsersWithoutAttendanceToday() {
        try {
            List<UserDTO> usersWithoutAttendanceToday = attendanceService.findUsersWithoutAttendanceToday();
            return ResponseEntity.ok(usersWithoutAttendanceToday);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.emptyList());
        }
    }

    @GetMapping("/peakAttendanceDay")
    public ResponseEntity<List<Object[]>> getPeakAttendanceDay() {
        try {
            List<Object[]> peakAttendanceDay = attendanceService.getPeakAttendanceDay();
            return peakAttendanceDay.isEmpty()
                    ? ResponseEntity.noContent().build()
                    : ResponseEntity.ok(peakAttendanceDay);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.emptyList());
        }
    }

    @GetMapping("/peakAttendanceMonth")
    public ResponseEntity<List<Object[]>> getPeakAttendanceMonth() {
        try {
            List<Object[]> peakAttendanceMonth = attendanceService.getPeakAttendanceMonth();
            return peakAttendanceMonth.isEmpty()
                    ? ResponseEntity.noContent().build()
                    : ResponseEntity.ok(peakAttendanceMonth);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.emptyList());
        }
    }

    @GetMapping("/lateCheckIns")
    public ResponseEntity<List<AttendanceDTO>> getLateCheckIns(
            @RequestParam("lateTime") String lateTime,
            @RequestParam("startDate") LocalDate startDate,
            @RequestParam("endDate") LocalDate endDate) {
        try {
            List<AttendanceDTO> lateCheckIns = attendanceService.getLateCheckIns(lateTime, startDate, endDate);
            return lateCheckIns.isEmpty()
                    ? ResponseEntity.noContent().build()
                    : ResponseEntity.ok(lateCheckIns);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.emptyList());
        }
    }

    @GetMapping("/searchByName")
    public ResponseEntity<List<AttendanceDTO>> getAttendancesByUserNamePart(@RequestParam("name") String name) {
        try {
            List<AttendanceDTO> attendances = attendanceService.getAttendancesByUserNamePart(name);
            return attendances.isEmpty()
                    ? ResponseEntity.noContent().build()
                    : ResponseEntity.ok(attendances);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.emptyList());
        }
    }

    @GetMapping("/roleAttendance")
    public ResponseEntity<List<AttendanceDTO>> getAttendanceByRole(
            @RequestParam("role") String role) {
        try {
            List<AttendanceDTO> attendances = attendanceService.getAttendanceByRole(role);
            return attendances.isEmpty()
                    ? ResponseEntity.noContent().build()
                    : ResponseEntity.ok(attendances);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.emptyList());
        }
    }

    @GetMapping("/todayAttendance/{userId}")
    public ResponseEntity<List<AttendanceDTO>> getTodayAttendanceByUserId(@PathVariable("userId") long userId) {
        try {
            List<AttendanceDTO> todayAttendance = attendanceService.getTodayAttendanceByUserId(userId);
            return todayAttendance.isEmpty()
                    ? ResponseEntity.noContent().build()
                    : ResponseEntity.ok(todayAttendance);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.emptyList());
        }
    }
}

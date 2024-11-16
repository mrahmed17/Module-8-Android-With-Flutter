package com.mrahmed.HRandPayrollManagementSystem.service;

import com.mrahmed.HRandPayrollManagementSystem.entity.Attendance;
import com.mrahmed.HRandPayrollManagementSystem.entity.User;
import com.mrahmed.HRandPayrollManagementSystem.repository.AttendanceRepository;
import com.mrahmed.HRandPayrollManagementSystem.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class AttendanceService {


    @Autowired
    private AttendanceRepository attendanceRepository;

    @Autowired
    private UserRepository userRepository;

    private final AttendanceMapper attendanceMapper = AttendanceMapper.INSTANCE;

    private final UserMapper userMapper = UserMapper.INSTANCE;

    public AttendanceDTO checkIn(long userId) {
        try {
            User user = userRepository.findById(userId)
                    .orElseThrow(() -> new RuntimeException("User not found with ID: " + userId));
            if (attendanceRepository.countByUserIdAndDate(userId, LocalDate.now()) > 0) {
                throw new RuntimeException("User has already checked in today.");
            }
            Attendance attendance = new Attendance();
            attendance.setDate(LocalDate.now());
            attendance.setClockInTime(LocalDateTime.now());
            attendance.setUser(user);
            Attendance savedAttendance = attendanceRepository.save(attendance);
            return attendanceMapper.toDTO(savedAttendance); // Map to DTO
        } catch (Exception e) {
            throw new RuntimeException("Error occurred while checking in: " + e.getMessage(), e);
        }
    }

    public AttendanceDTO checkOut(long userId) {
        try {
            Attendance attendance = attendanceRepository.findLastAttendanceForUser(userId, LocalDate.now())
                    .orElseThrow(() -> new RuntimeException("No check-in found for today's check-out"));
            if (attendance.getClockOutTime() != null) {
                throw new RuntimeException("User has already checked out today.");
            }
            attendance.setClockOutTime(LocalDateTime.now());
            Attendance updatedAttendance = attendanceRepository.save(attendance);
            return attendanceMapper.toDTO(updatedAttendance); // Map to DTO
        } catch (Exception e) {
            throw new RuntimeException("Error occurred while checking out: " + e.getMessage(), e);
        }
    }

    public List<AttendanceDTO> getOvertimeForUser(Long userId, LocalDate startDate, LocalDate endDate) {
        List<Attendance> attendances = attendanceRepository.findAttendancesByUserIdAndDateRange(userId, startDate, endDate);
        return attendances.stream()
                .filter(this::isOvertime)
                .map(attendanceMapper::toDTO) // Map each entity to DTO
                .collect(Collectors.toList());
    }

    private boolean isOvertime(Attendance attendance) {
        if (attendance.getClockInTime() == null || attendance.getClockOutTime() == null) {
            return false;
        }
        Duration duration = Duration.between(attendance.getClockInTime(), attendance.getClockOutTime());
        long hours = duration.toHours();
        return hours > 8;
    }

    public List<AttendanceDTO> getTodayAttendances() {
        LocalDate today = LocalDate.now();
        List<Attendance> attendances = attendanceRepository.findAttendancesForToday(today);
        return attendanceMapper.toDTOList(attendances); // Use the mapper
    }

    public List<AttendanceDTO> getAllAttendances() {
        List<Attendance> attendances = attendanceRepository.findAll(); // Or however you're fetching attendances

        // Use mapToDTOList to convert the list of attendances
        return mapToDTOList(attendances);
    }

    public AttendanceDTO findAttendanceById(long id) {
        Attendance attendance = attendanceRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Attendance not found with id: " + id));
        return attendanceMapper.toDTO(attendance); // Map to DTO
    }

    public Map<UserDTO, Long> getUsersAttendanceInRange(LocalDate startDate, LocalDate endDate) {
        List<Attendance> attendances = attendanceRepository.findAttendancesInRange(startDate, endDate);

        // Convert User entities to UserDTOs and count attendances for each user
        return attendances.stream()
                .collect(Collectors.groupingBy(
                        attendance -> userMapper.toDTO(attendance.getUser()),
                        Collectors.counting()));
    }


    public List<AttendanceDTO> getAttendanceByUserId(Long id) {
        List<Attendance> attendances = attendanceRepository.findAllByUserId(id);
        return attendanceMapper.toDTOList(attendances); // Use the mapper
    }

    public List<UserDTO> findUsersWithoutAttendanceToday() {
        List<User> users = attendanceRepository.findUsersWithoutAttendanceForToday(LocalDate.now());
        return userMapper.toDTOList(users); // Use the MapStruct-generated mapper
    }

    public List<Object[]> getPeakAttendanceDay() {
        return attendanceRepository.findPeakAttendanceDay();
    }

    public List<Object[]> getPeakAttendanceMonth() {
        return attendanceRepository.findPeakAttendanceMonth();
    }

    public List<AttendanceDTO> getLateCheckIns(String lateTime, LocalDate startDate, LocalDate endDate) {
        List<Attendance> attendances = attendanceRepository.findLateCheckIns(lateTime, startDate, endDate);
        return attendanceMapper.toDTOList(attendances); // Use the mapper
    }

    public List<AttendanceDTO> getAttendancesByUserNamePart(String name) {
        List<Attendance> attendances = attendanceRepository.findAttendancesByUserNamePart(name);
        return attendanceMapper.toDTOList(attendances); // Use the mapper
    }

    public List<AttendanceDTO> getAttendanceByRole(String role) {
        List<Attendance> attendances = attendanceRepository.findAttendanceByRole(role);
        return attendanceMapper.toDTOList(attendances); // Use the mapper
    }

    public List<AttendanceDTO> getTodayAttendanceByUserId(long userId) {
        List<Attendance> attendances = attendanceRepository.findTodayAttendanceByUserId(userId);
        return attendanceMapper.toDTOList(attendances); // Use the mapper
    }

    private List<AttendanceDTO> mapToDTOList(List<Attendance> attendances) {
        return attendanceMapper.toDTOList(attendances);
    }
}

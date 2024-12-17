package com.mrahmed.HRandPayrollManagementSystem.restcontroller;

import com.mrahmed.HRandPayrollManagementSystem.entity.Bonus;
import com.mrahmed.HRandPayrollManagementSystem.entity.BonusType;
import com.mrahmed.HRandPayrollManagementSystem.entity.User;
import com.mrahmed.HRandPayrollManagementSystem.repository.BonusRepository;
import com.mrahmed.HRandPayrollManagementSystem.repository.UserRepository;
import com.mrahmed.HRandPayrollManagementSystem.service.BonusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.List;

@RestController
@RequestMapping("/api/bonuses")
@CrossOrigin("*")
public class BonusController {

    @Autowired
    private BonusService bonusService;
    @Autowired
    private BonusRepository bonusRepository;
    @Autowired
    private UserRepository userRepository;

    // Create a new Bonus
//    @PostMapping("/assign")
//    public ResponseEntity<Bonus> assignBonus(@RequestBody Bonus bonus) {
//        try {
//            return ResponseEntity.ok(bonusService.assignBonusToEmployee(bonus));
//        } catch (IllegalArgumentException ex) {
//            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
//        }
//    }

    // Create a new Bonus
    @PostMapping("/assign")
    public ResponseEntity<Bonus> assignBonus(@RequestBody Bonus assignBonus) {
        try {
            // Create a new Bonus object from the request
            Bonus bonus = new Bonus();
            User employee = userRepository.findById(assignBonus.getId())
                    .orElseThrow(() -> new IllegalArgumentException("Employee not found with ID: " + assignBonus.getId()));

            bonus.setUser(employee);
            bonus.setBonusAmount(assignBonus.getBonusAmount());
            bonus.setBonusDate(LocalDateTime.now());
            bonus.setBonusType(BonusType.PERFORMANCE);  // Assuming PERFORMANCE bonus type

            // Save the bonus
            Bonus savedBonus = bonusRepository.save(bonus);
            return ResponseEntity.ok(savedBonus);
        } catch (IllegalArgumentException ex) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }
    }



    // Update a Bonus
    @PutMapping("/update/{id}")
    public ResponseEntity<Bonus> updateBonus(@PathVariable Long id, @RequestBody Bonus updatedBonus) {
        try {
            return ResponseEntity.ok(bonusService.updateBonus(id, updatedBonus));
        } catch (RuntimeException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    // Delete a Bonus
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<?> deleteBonus(@PathVariable Long id) {
        try {
            bonusService.deleteBonus(id);
            return ResponseEntity.ok("Bonus deleted successfully.");
        } catch (RuntimeException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Bonus not found.");
        }
    }

    // Get Bonus by ID
    @GetMapping("/find/{id}")
    public ResponseEntity<Bonus> getBonusById(@PathVariable Long id) {
        try {
            return ResponseEntity.ok(bonusService.getBonusById(id));
        } catch (RuntimeException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    // Get all Bonuses
    @GetMapping("/allBonuses")
    public ResponseEntity<List<Bonus>> getAllBonuses(@RequestParam(defaultValue = "0") int page,
                                                     @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page, size);
        return ResponseEntity.ok(bonusRepository.findAll(pageable).getContent());
    }

    @GetMapping("/employees")
    public ResponseEntity<List<Bonus>> getAllEmployees() {
        System.out.println("Fetching all employees bonuses");
        List<Bonus> bonuses = bonusService.getAllEmployees();
        return ResponseEntity.ok(bonuses);
    }

    // Get total bonus for a user
    @GetMapping("/total/user/{userId}")
    public ResponseEntity<Double> getTotalBonusForUser(@PathVariable Long userId) {
        return ResponseEntity.ok(bonusService.getTotalBonusForUser(userId));
    }

    // Get bonuses between two dates
    @GetMapping("/between")
    public ResponseEntity<?> getBonusesBetweenDates(
            @RequestParam("startDate") String startDateStr,
            @RequestParam("endDate") String endDateStr) {
        try {
            LocalDateTime startDate = LocalDateTime.parse(startDateStr);
            LocalDateTime endDate = LocalDateTime.parse(endDateStr);
            return ResponseEntity.ok(bonusService.getBonusesBetweenDates(startDate, endDate));
        } catch (DateTimeParseException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Invalid date format. Please use the correct format: yyyy-MM-ddTHH:mm:ss.");
        }
    }

    // Get total bonus for a specific month and year
    @GetMapping("/monthly/{month}/{year}")
    public ResponseEntity<Double> getTotalBonusForMonth(@PathVariable int month, @PathVariable int year) {
        return ResponseEntity.ok(bonusService.getTotalBonusForMonth(month, year));
    }

    // Count bonuses for a user in a specific year
    @GetMapping("/count/user/{userId}/year/{year}")
    public ResponseEntity<Long> countBonusesForUserInYear(@PathVariable Long userId, @PathVariable int year) {
        return ResponseEntity.ok(bonusService.countBonusesForUserInYear(userId, year));
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<List<Bonus>> getBonusesByUser(@PathVariable Long userId) {
        List<Bonus> bonuses = bonusService.getBonusesByUser(userId);
        return bonuses.isEmpty()
                ? ResponseEntity.status(HttpStatus.NOT_FOUND).body(null)
                : ResponseEntity.ok(bonuses);
    }


}

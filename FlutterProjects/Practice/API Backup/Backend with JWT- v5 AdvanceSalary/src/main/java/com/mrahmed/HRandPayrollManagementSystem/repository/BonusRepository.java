package com.mrahmed.HRandPayrollManagementSystem.repository;

import com.mrahmed.HRandPayrollManagementSystem.entity.Bonus;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface BonusRepository extends JpaRepository<Bonus, Long> {

    // findByBonusId
    Optional<Bonus> findById(Long id);

    @Query("SELECT SUM(b.bonusAmount) FROM Bonus b WHERE b.user.id = :userId")
    double getTotalBonusForUser(@Param("userId") Long userId);

    @Query("SELECT b FROM Bonus b WHERE b.bonusDate BETWEEN :startDate AND :endDate")
    List<Bonus> getBonusesBetweenDates(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);

    // Corrected query to fetch the latest bonus for a user
    @Query("SELECT b FROM Bonus b WHERE b.user.id = :userId ORDER BY b.bonusDate DESC")
    List<Bonus> getLatestBonusForUser(@Param("userId") Long userId, Pageable pageable);
}

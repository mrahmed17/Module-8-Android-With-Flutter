package com.mrahmed.HRandPayrollManagementSystem.repository;

import com.mrahmed.HRandPayrollManagementSystem.entity.AdvanceSalary;
import com.mrahmed.HRandPayrollManagementSystem.entity.RequestStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface AdvanceSalaryRepository extends JpaRepository<AdvanceSalary, Long> {

//    @Override
//    Optional<AdvanceSalary> findById(Long id);

    List<AdvanceSalary> findByUserId(Long userId);

    @Query("SELECT a FROM AdvanceSalary a WHERE a.user.id = :userId AND a.status = :status")
    List<AdvanceSalary> findByUserAndStatus(@Param("userId") Long userId, @Param("status") RequestStatus status);

    @Query("SELECT a FROM AdvanceSalary a WHERE a.advanceDate BETWEEN :startDate AND :endDate")
    List<AdvanceSalary> findByDateRange(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);

    @Query("SELECT a FROM AdvanceSalary a WHERE a.user.id = :userId ORDER BY a.advanceDate DESC LIMIT 5")
    List<AdvanceSalary> findTop5ByUserIdOrderByAdvanceDateDesc(Long userId);

    @Query("SELECT a FROM AdvanceSalary a WHERE a.status = 'PENDING'")
    List<AdvanceSalary> findPendingSalaryRequests();

    @Query("SELECT  a FROM AdvanceSalary a WHERE a.status = 'REJECTED'")
    List<AdvanceSalary> findRejectedSalaryRequests();

    @Query("SELECT  a FROM AdvanceSalary a WHERE a.user.id = :userId AND a.status = 'APPROVED'")
    List<AdvanceSalary> findApprovedSalaryByUser(@Param("userId") Long userId);

    @Query("SELECT  a FROM AdvanceSalary a WHERE a.user.id = :userId AND a.advanceDate BETWEEN :startDate AND :endDate")
    List<AdvanceSalary> findAdvanceSalaryByUserAndDateRange(@Param("userId") Long userId, @Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);


}

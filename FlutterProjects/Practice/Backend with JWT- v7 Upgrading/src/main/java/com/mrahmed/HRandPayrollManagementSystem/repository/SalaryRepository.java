package com.mrahmed.HRandPayrollManagementSystem.repository;

import com.mrahmed.HRandPayrollManagementSystem.entity.RequestStatus;
import com.mrahmed.HRandPayrollManagementSystem.entity.Salary;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface SalaryRepository extends JpaRepository<Salary, Long> {
    Optional<Salary> findFirstByUserIdOrderByPaymentDateDesc(Long userId);
    List<Salary> findByPaymentDateBetween(LocalDateTime startDate, LocalDateTime endDate);
    List<Salary> findBySalaryStatus(RequestStatus status);

}



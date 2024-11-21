package com.mrahmed.HRandPayrollManagementSystem.service;

import com.mrahmed.HRandPayrollManagementSystem.entity.AdvanceSalary;
import com.mrahmed.HRandPayrollManagementSystem.entity.RequestStatus;
import com.mrahmed.HRandPayrollManagementSystem.repository.AdvanceSalaryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class AdvanceSalaryService {

    @Autowired
    private AdvanceSalaryRepository advanceSalaryRepository;

    public AdvanceSalary applyAdvanceSalary(AdvanceSalary advanceSalary) {
        return advanceSalaryRepository.save(advanceSalary);
    }

    public AdvanceSalary updateAdvanceSalary(AdvanceSalary advanceSalary) {
        return advanceSalaryRepository.save(advanceSalary);
    }

    public AdvanceSalary approveAdvanceSalary(Long id) {
        AdvanceSalary advanceSalary = advanceSalaryRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("AdvanceSalary with ID " + id + " not found"));
        advanceSalary.setStatus(RequestStatus.APPROVED);
        advanceSalary.setIsPaid(true);
        advanceSalary.setPaidDate(java.time.LocalDateTime.now());
        return advanceSalaryRepository.save(advanceSalary);
    }

    public AdvanceSalary getAdvanceSalaryById(Long id) {
        return advanceSalaryRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("AdvanceSalary with ID " + id + " not found"));
    }

    // Get all AdvanceSalary records
    public List<AdvanceSalary> getAllAdvanceSalaries() {
        return advanceSalaryRepository.findAll();
    }

    // Get AdvanceSalaries by User ID
    public List<AdvanceSalary> getAdvanceSalariesByUserId(Long userId) {
        return advanceSalaryRepository.findByUserId(userId);
    }

    // Delete AdvanceSalary by ID
    public void deleteAdvanceSalary(Long id) {
        if (advanceSalaryRepository.existsById(id)) {
            advanceSalaryRepository.deleteById(id);
        } else {
            throw new IllegalArgumentException("AdvanceSalary with ID " + id + " does not exist.");
        }
    }

    public Optional<AdvanceSalary> getAdvanceSalariesByUserAndStatus(Long userId, RequestStatus status) {
        return advanceSalaryRepository.findByUserIdAndStatus(userId, status);
    }

    public List<AdvanceSalary> getAdvanceSalariesByStatus(RequestStatus status) {
        return advanceSalaryRepository.findByStatus(status);
    }
}

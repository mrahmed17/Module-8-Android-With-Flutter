package com.mrahmed.HRandPayrollManagementSystem.restcontroller;

import com.mrahmed.HRandPayrollManagementSystem.service.PaySlipService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/payslips")
@CrossOrigin("*")
public class PaySlipController {

    @Autowired
    private PaySlipService paySlipService;

    // Create PaySlip
    @GetMapping("/payslip/{userId}")
    public String getPayslip(@PathVariable long userId) {
        return paySlipService.generatePaySlip(userId);
    }

    @GetMapping("/user/{userId}/payslip-data")
    public ResponseEntity<?> getUserPayslipData(@PathVariable long userId) {
        return ResponseEntity.ok(paySlipService.getUserPayslipData(userId));
    }


}

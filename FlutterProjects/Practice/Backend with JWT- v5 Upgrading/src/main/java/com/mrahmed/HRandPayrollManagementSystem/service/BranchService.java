package com.mrahmed.HRandPayrollManagementSystem.service;

import com.mrahmed.HRandPayrollManagementSystem.entity.Branch;
import com.mrahmed.HRandPayrollManagementSystem.entity.Department;
import com.mrahmed.HRandPayrollManagementSystem.repository.BranchRepository;
import com.mrahmed.HRandPayrollManagementSystem.repository.DepartmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

/**
 * @Project: Backend with JWT- v2 as Sir
 * @Author: M. R. Ahmed
 * @Created at: 11/10/2024
 */

@Service
public class BranchService {

    @Autowired
    private BranchRepository branchRepository;

    @Value("${upload.directory}")
    private String uploadDir;

    public String saveBranchImage(MultipartFile file, String fullName) throws IOException {
        Path uploadPath = Paths.get(uploadDir, "branchPhotos");
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }
        String originalFilename = file.getOriginalFilename();
        String fileExtension = (originalFilename != null && originalFilename.contains("."))
                ? originalFilename.substring(originalFilename.lastIndexOf("."))
                : "";
        String sanitizedFullName = fullName.replaceAll("[^a-zA-Z0-9]", "_");
        if (sanitizedFullName.length() > 25) {
            sanitizedFullName = sanitizedFullName.substring(0, 25);
        }
        String uniqueFilename = sanitizedFullName + "_" + UUID.randomUUID() + fileExtension;
        Path filePath = uploadPath.resolve(uniqueFilename);
        Files.copy(file.getInputStream(), filePath);
        return uniqueFilename;
    }

    public void saveBranch(Branch branch) {
        branchRepository.save(branch);
    }

    public List<Branch> getALlBranches() {
        return branchRepository.findAll();
    }

//        @SuppressWarnings("unused")
    public void updateBranch(long id, Branch updatedBranch) {
        Branch existingBranch = branchRepository.findById(id)
                .orElseThrow(() -> new
                        RuntimeException("Branch Not Found by this Id"));

        existingBranch.setName(updatedBranch.getName());
        existingBranch.setAddress(updatedBranch.getAddress());
        existingBranch.setCell(updatedBranch.getCell());
        existingBranch.setEmail(updatedBranch.getEmail());
        existingBranch.setBranchImage(updatedBranch.getBranchImage());

        branchRepository.save(existingBranch);
    }

    public void deleteBranch(long id) {
        branchRepository.deleteById(id);
    }

    public Branch findById(long id) {
        return branchRepository.findById(id)
                .orElseThrow(() -> new
                        RuntimeException("Branch Not Found by this Id"));
    }


}

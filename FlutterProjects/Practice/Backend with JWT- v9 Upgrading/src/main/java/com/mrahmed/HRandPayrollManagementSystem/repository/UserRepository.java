package com.mrahmed.HRandPayrollManagementSystem.repository;

import com.mrahmed.HRandPayrollManagementSystem.entity.Role;
import com.mrahmed.HRandPayrollManagementSystem.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    // Finding Users by id for profiles
    Optional<User> findById(long id);

    // Find a single user by email for authentication
    Optional<User> findByEmail(String email);

    // Find users by role with pagination
    @Query("SELECT u FROM User u WHERE u.role = :role")
    List<User> findAllByRole(@Param("role") Role role);

    // Find users with salary greater than or equal to a certain amount with pagination
    @Query("SELECT u FROM User u WHERE u.basicSalary >= :salary")
    List<User> findUsersWithSalaryGreaterThanOrEqual(@Param("salary") double salary);

    // Find users with salary less than or equal to a certain amount with pagination
    @Query("SELECT u FROM User u WHERE u.basicSalary <= :salary")
    List<User> findUsersWithSalaryLessThanOrEqual(@Param("salary") double salary );

//    // Search user records by full name or part of the name with pagination
//    @Query("SELECT u FROM User u WHERE LOWER(u.name) LIKE LOWER(CONCAT('%', :name, '%'))")
//    List<User> findByFullNameContaining(@Param("name") String name );
//
//    // Search user records by gender with pagination
//    @Query("SELECT u FROM User u WHERE u.gender = :gender")
//    List<User> findByGender(@Param("gender") String gender );

    // Search user records by joined date with pagination
    @Query("SELECT u FROM User u WHERE u.joinedDate = :joinedDate")
    List<User> findByJoinedDate(@Param("joinedDate") LocalDate joinedDate );

    // Dynamic filtering  query
    @Query("SELECT u FROM User u WHERE LOWER(u.name) LIKE LOWER(CONCAT('%', :name, '%')) AND u.gender = :gender")
    List<User> findEmployeesByFilters(@Param("name") String name, @Param("gender") String gender);


}

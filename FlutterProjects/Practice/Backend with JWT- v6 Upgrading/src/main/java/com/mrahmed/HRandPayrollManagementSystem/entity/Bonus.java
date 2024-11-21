package com.mrahmed.HRandPayrollManagementSystem.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "bonuses")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString(exclude = "user")
public class Bonus {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private double bonusAmount;

    private LocalDateTime bonusDate;

    private String bonusType; // Performance, Annual, Festival, Promotional

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User user;


}

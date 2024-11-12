package com.emranhss.ReviewSprintBoot.repository;

import com.emranhss.ReviewSprintBoot.entity.Location;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;



@Repository
public interface LocationRepository extends JpaRepository<Location, Integer> {


}

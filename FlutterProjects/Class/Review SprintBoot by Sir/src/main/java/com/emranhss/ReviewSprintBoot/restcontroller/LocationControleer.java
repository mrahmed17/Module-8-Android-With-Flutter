package com.emranhss.ReviewSprintBoot.restcontroller;


import com.emranhss.ReviewSprintBoot.entity.Location;
import com.emranhss.ReviewSprintBoot.entity.Room;
import com.emranhss.ReviewSprintBoot.repository.LocationRepository;
import com.emranhss.ReviewSprintBoot.service.LocationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/location")
public class LocationControleer {

    @Autowired
    private LocationService locationService;
    @Autowired
    private LocationRepository locationRepository;


    @GetMapping("/")
    public ResponseEntity<List<Location>> getAllLocations() {
//        List<Location> locations = locationService.getALlLocation();
        List<Location> locations = locationRepository.findAll();
        return ResponseEntity.ok(locations);
    }


}

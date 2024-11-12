package com.emranhss.ReviewSprintBoot.restcontroller;


import com.emranhss.ReviewSprintBoot.entity.Hotel;
import com.emranhss.ReviewSprintBoot.service.HotelService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/hotel")

public class HotelController {

    @Autowired
   private HotelService hotelService;


    @PostMapping("/save")
    public ResponseEntity<Map<String, String>> saveHotel(
            @RequestPart(value = "hotel") String hotelJson,
            @RequestPart(value = "image") MultipartFile file
    ) throws IOException {

        // Convert JSON string to Hotel object
        ObjectMapper objectMapper = new ObjectMapper();
        Hotel hotel = objectMapper.readValue(hotelJson, Hotel.class);

        // Save the hotel and the image
        try {
            hotelService.saveHotel(hotel, file);

            // Create a response map
            Map<String, String> response = new HashMap<>();
            response.put("message", "Hotel added successfully");
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            // Return error as JSON
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", "Failed to add hotel: " + e.getMessage());
            return new ResponseEntity<>(errorResponse, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }




    @GetMapping("/")
    public ResponseEntity<List<Hotel>> getAllHotel() {
        List<Hotel> hotels = hotelService.getAllHotel();
        return ResponseEntity.ok(hotels);
    }

 @GetMapping("/h/searchhotel")
    public ResponseEntity<List<Hotel>> findHotelsByLocationName(@RequestParam(value = "locationName") String locationName) {
        List<Hotel> hotels = hotelService.findHotelsByLocationName(locationName);
        return ResponseEntity.ok(hotels);
    }


    @GetMapping("/{id}")
    public ResponseEntity<Hotel> findHotelById(@PathVariable int id) {
        try {
            Hotel hotel = hotelService.findHotelById(id);
            return ResponseEntity.ok(hotel);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }



}

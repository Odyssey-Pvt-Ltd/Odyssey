package com.Odyssey.Odyssey.controller;

import com.Odyssey.Odyssey.Request.CreateListingRequest;
import com.Odyssey.Odyssey.model.Listing;
import com.Odyssey.Odyssey.model.Shop;
import com.Odyssey.Odyssey.model.User;
import com.Odyssey.Odyssey.service.ListingService;
import com.Odyssey.Odyssey.service.ShopService;
import com.Odyssey.Odyssey.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/listing")
public class ListingController {
    @Autowired
    private ListingService listingService;

    @Autowired
    private UserService userService;

    @Autowired
    private ShopService shopService;

    @GetMapping("/search")
    public ResponseEntity<List<Listing>> SearchListing(@RequestParam String name, @RequestHeader("Authorization")String jwt) throws Exception {
        User user=userService.findUserByJwtToken(jwt);
        List<Listing> Listings=listingService.SearchListing(name);
        return new ResponseEntity<>(Listings, HttpStatus.CREATED);
    }

    @GetMapping("/shop/{shopId}")
    public ResponseEntity<List<Listing>>getShopsListing(@RequestParam boolean active,@RequestParam boolean Inactive ,@RequestParam(required = false)String ListingCategory,@PathVariable Long shopId, @RequestHeader("Authorization")String jwt) throws Exception {
        User user=userService.findUserByJwtToken(jwt);
        List<Listing> Listings=listingService.getShopsListing(shopId,ListingCategory,Inactive,active);
        return new ResponseEntity<>(Listings, HttpStatus.OK);
    }
}

package com.Odyssey.Odyssey.controller;

import com.Odyssey.Odyssey.Request.CreateListingRequest;
import com.Odyssey.Odyssey.model.Category;
import com.Odyssey.Odyssey.model.Listing;
import com.Odyssey.Odyssey.model.Shop;
import com.Odyssey.Odyssey.model.User;
import com.Odyssey.Odyssey.response.MessageResponse;
import com.Odyssey.Odyssey.service.CategoryService;
import com.Odyssey.Odyssey.service.ListingService;
import com.Odyssey.Odyssey.service.ShopService;
import com.Odyssey.Odyssey.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/admin/listing")
public class AdminListingController {
    @Autowired
    private ListingService listingService;

    @Autowired
    private UserService userService;

    @Autowired
    private ShopService shopService;

    @Autowired
    private CategoryService categoryService;

    @PostMapping
    public ResponseEntity<Listing>CreateListing(@RequestBody CreateListingRequest req,
                                                @RequestHeader("Authorization")String jwt) throws Exception {
        User user=userService.findUserByJwtToken(jwt);
        Shop shop=shopService.findShopById(req.getShopID());
        Category category = categoryService.findCategoryById(req.getCategoryId());
        Listing listing = listingService.CreatetListing(req, category, shop);
//        Listing listing=listingService.CreatetListing(req,req.getCategory(),shop);
        return new ResponseEntity<>(listing, HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<MessageResponse>DeleteListing(@PathVariable Long id, @RequestHeader("Authorization")String jwt) throws Exception {
        User user=userService.findUserByJwtToken(jwt);
        listingService.DeleteListing(id);
        MessageResponse res=new MessageResponse();
        res.setMessage("Successfully deleted listing");
        return new ResponseEntity<>(res, HttpStatus.OK);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Listing>updateListingAvailabilityStatus(@PathVariable Long id, @RequestHeader("Authorization")String jwt) throws Exception {
        User user=userService.findUserByJwtToken(jwt);
        Listing listing=listingService.updateListingAvailabilityStatus(id);
        return new ResponseEntity<>(listing,HttpStatus.OK);
    }


}

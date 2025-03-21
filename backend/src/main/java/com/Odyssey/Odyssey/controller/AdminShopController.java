package com.Odyssey.Odyssey.controller;

import com.Odyssey.Odyssey.Request.CreateShopRequest;
import com.Odyssey.Odyssey.model.Shop;
import com.Odyssey.Odyssey.model.User;
import com.Odyssey.Odyssey.response.MassageResponse;
import com.Odyssey.Odyssey.service.ShopService;
import com.Odyssey.Odyssey.service.UserService;
import jakarta.persistence.ManyToOne;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/admin/shop")
public class AdminShopController {

    @Autowired
    private ShopService shopService;

    @Autowired
    private UserService userService;

    @PutMapping("/{id}")
    public ResponseEntity<Shop> UpdateShop(
            @RequestBody CreateShopRequest req,
            @RequestHeader("Authorization") String jwt,
            @PathVariable Long id
            ) throws Exception {
        User user =userService.findUserByJwtToken(jwt);

        Shop shop = shopService.updateShop(id,req);
        return new ResponseEntity<>(shop, HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<MassageResponse> DeleteShop(
            @RequestBody CreateShopRequest req,
            @RequestHeader("Authorization") String jwt,
            @PathVariable Long id
    ) throws Exception {
        User user =userService.findUserByJwtToken(jwt);

        shopService.deleteShop(id);

        MassageResponse res = new MassageResponse();
        res.setMessage("Successfully deleted shop");
        return new ResponseEntity<>(res, HttpStatus.OK);
    }

    @PutMapping("/{id}/Status")
    public ResponseEntity<Shop> UpdateShopStatus(
            @RequestBody CreateShopRequest req,
            @RequestHeader("Authorization") String jwt,
            @PathVariable Long id
    ) throws Exception {
        User user =userService.findUserByJwtToken(jwt);

        Shop shop = shopService.updateShopStatus(id);


        return new ResponseEntity<>(shop, HttpStatus.OK);
    }

    @GetMapping("/user")
    public ResponseEntity<Shop> findShopByUserId(
            @RequestBody CreateShopRequest req,
            @RequestHeader("Authorization") String jwt

    ) throws Exception {
        User user =userService.findUserByJwtToken(jwt);

        Shop shop = shopService.findShopByUserId(user.getId());


        return new ResponseEntity<>(shop, HttpStatus.CREATED);
    }



}

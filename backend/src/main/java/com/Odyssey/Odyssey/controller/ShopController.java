package com.Odyssey.Odyssey.controller;


import com.Odyssey.Odyssey.Request.CreateShopRequest;
import com.Odyssey.Odyssey.dto.ShopDTO;
import com.Odyssey.Odyssey.model.Shop;
import com.Odyssey.Odyssey.model.User;
import com.Odyssey.Odyssey.service.ShopService;
import com.Odyssey.Odyssey.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/shop")
public class ShopController {


    @Autowired
    private ShopService shopService;

    @Autowired
    private UserService userService;

    @GetMapping("/search")
    public ResponseEntity<List<Shop>> searchShop(

            @RequestHeader("Authorization") String jwt,
            @RequestParam String keyword
    ) throws Exception {
        User user =userService.findUserByJwtToken(jwt);

        List<Shop> shop = shopService.searchShops(keyword);

        return new ResponseEntity<>(shop, HttpStatus.OK);
    }

    @GetMapping()
    public ResponseEntity<List<Shop>> getAllShop(

            @RequestHeader("Authorization") String jwt

    ) throws Exception {
        User user =userService.findUserByJwtToken(jwt);

        List<Shop> shop = shopService.getAllShops();

        return new ResponseEntity<>(shop, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity <Shop> findShopById(

            @RequestHeader("Authorization") String jwt,
            @PathVariable Long id

    ) throws Exception {
        User user =userService.findUserByJwtToken(jwt);

        Shop shop = shopService.findShopById(id);

        return new ResponseEntity<>(shop, HttpStatus.OK);
    }

    @PutMapping("/{id}/add-favorites")
    public ResponseEntity<ShopDTO> addFavorites(
            @RequestHeader("Authorization") String jwt,
            @PathVariable Long id // Changed from @RequestParam to @PathVariable
    ) throws Exception {
        User user = userService.findUserByJwtToken(jwt);
        ShopDTO shop = shopService.addToFavorites(id, user);
        return new ResponseEntity<>(shop, HttpStatus.OK);
    }




}

package com.Odyssey.Odyssey.controller;

import com.Odyssey.Odyssey.Request.CreateShopRequest;
import com.Odyssey.Odyssey.model.Shop;
import com.Odyssey.Odyssey.model.User;
import com.Odyssey.Odyssey.response.MessageResponse;
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

    @PutMapping()
    public ResponseEntity<Shop> createShop(
            @RequestBody CreateShopRequest req,
            @RequestHeader("Authorization") String jwt
    ) throws Exception {
        User user =userService.findUserByJwtToken(jwt);

        Shop shop = shopService.createShop(req, user);
        return new ResponseEntity<>(shop, HttpStatus.CREATED);
    }



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
    public ResponseEntity<MessageResponse> DeleteShop(

            @RequestHeader("Authorization") String jwt,
            @PathVariable Long id
    ) throws Exception {
        User user =userService.findUserByJwtToken(jwt);

        shopService.deleteShop(id);

        MessageResponse res = new MessageResponse();
        res.setMessage("Successfully deleted shop");
        return new ResponseEntity<>(res, HttpStatus.OK);
    }

    @PutMapping("/{id}/Status")
    public ResponseEntity<Shop> UpdateShopStatus(

            @RequestHeader("Authorization") String jwt,
            @PathVariable Long id
    ) throws Exception {
        User user =userService.findUserByJwtToken(jwt);

        Shop shop = shopService.updateShopStatus(id);


        return new ResponseEntity<>(shop, HttpStatus.OK);
    }

    @GetMapping("/user")
    public ResponseEntity<Shop> findShopByUserId(

            @RequestHeader("Authorization") String jwt

    ) throws Exception {
        User user =userService.findUserByJwtToken(jwt);

        Shop shop = shopService.findShopByUserId(user.getId());


        return new ResponseEntity<>(shop, HttpStatus.CREATED);
    }

}

package com.Odyssey.Odyssey.controller;


import com.Odyssey.Odyssey.model.Category;
import com.Odyssey.Odyssey.model.User;
import com.Odyssey.Odyssey.service.CategoryService;
import com.Odyssey.Odyssey.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private UserService userService;

    @PostMapping("admin/category")
    public ResponseEntity<Category> createCategory(@RequestBody Category category,
                                                   @RequestHeader("Authorization") String jwt) throws Exception {

        User user = userService.findUserByJwtToken(jwt);

        Category createdCategory = categoryService.createCategory(category.getName(), user.getId());
        return new ResponseEntity<>(createdCategory, HttpStatus.OK);
    }

    @GetMapping("/category/shop")
    public ResponseEntity<Category> getShopCategory(@RequestHeader("Authorization") String jwt) throws Exception {

        User user = userService.findUserByJwtToken(jwt);

        Category createdCategory = categoryService.findCategoryById(user.getId());

        return new ResponseEntity<>(createdCategory, HttpStatus.CREATED);
    }




}

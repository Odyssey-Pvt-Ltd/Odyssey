package com.Odyssey.Odyssey.controller;

import com.Odyssey.Odyssey.model.Category;
import com.Odyssey.Odyssey.model.Shop;
import com.Odyssey.Odyssey.service.CategoryService;
import com.Odyssey.Odyssey.service.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ShopService shopService;

    @PostMapping("/{shopId}")
    public ResponseEntity<Category> createCategory(@PathVariable Long shopId, @RequestParam String name) throws Exception {
        Shop shop = shopService.findShopById(shopId);
        Category category = categoryService.createCategory(name, shop);
        return new ResponseEntity<>(category, HttpStatus.CREATED);
    }

    @GetMapping("/shop/{shopId}")
    public ResponseEntity<List<Category>> getCategoriesByShop(@PathVariable Long shopId) {
        List<Category> categories = categoryService.getCategoriesByShop(shopId);
        return new ResponseEntity<>(categories, HttpStatus.OK);
    }

    @DeleteMapping("/{categoryId}")
    public ResponseEntity<Void> deleteCategory(@PathVariable Long categoryId) {
        categoryService.deleteCategory(categoryId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @PutMapping("/{categoryId}")
    public ResponseEntity<Category> updateCategory(@PathVariable Long categoryId, @RequestParam String name) {
        Category updatedCategory = categoryService.updateCategory(categoryId, name);
        return new ResponseEntity<>(updatedCategory, HttpStatus.OK);
    }
}
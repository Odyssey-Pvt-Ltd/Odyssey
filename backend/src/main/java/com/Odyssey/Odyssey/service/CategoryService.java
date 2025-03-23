package com.Odyssey.Odyssey.service;

import com.Odyssey.Odyssey.model.Category;
import com.Odyssey.Odyssey.model.Shop;

import java.util.List;

public interface CategoryService {
    Category createCategory(String name, Shop shop);
    List<Category> getCategoriesByShop(Long shopId);
    void deleteCategory(Long categoryId);
    Category updateCategory(Long categoryId, String name);
}
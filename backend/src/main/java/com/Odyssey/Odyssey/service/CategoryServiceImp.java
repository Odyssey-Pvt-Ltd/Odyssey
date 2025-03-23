package com.Odyssey.Odyssey.service;

import com.Odyssey.Odyssey.model.Category;
import com.Odyssey.Odyssey.model.Shop;
import com.Odyssey.Odyssey.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryServiceImp implements CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    @Override
    public Category createCategory(String name, Shop shop) {
        Category category = new Category();
        category.setName(name);
        category.setShop(shop);
        return categoryRepository.save(category);
    }

    @Override
    public List<Category> getCategoriesByShop(Long shopId) {
        return categoryRepository.findByShopId(shopId);
    }

    @Override
    public void deleteCategory(Long categoryId) {
        categoryRepository.deleteById(categoryId);
    }

    @Override
    public Category updateCategory(Long categoryId, String name) {
        Category category = categoryRepository.findById(categoryId)
                .orElseThrow(() -> new RuntimeException("Category not found"));
        category.setName(name);
        return categoryRepository.save(category);
    }
}
package com.Odyssey.Odyssey.service;

import com.Odyssey.Odyssey.model.Category;
import com.Odyssey.Odyssey.model.Shop;
import com.Odyssey.Odyssey.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CategoryServiceImp implements CategoryService{

    @Autowired
    private ShopService shopService;

    @Autowired
    private CategoryRepository categoryRepository;

    @Override
    public Category createCategory(String name, Long user_id) throws Exception {
        Shop shop = shopService.findShopById(user_id);
        Category category = new Category();
        category.setName(name);
        category.setShop(shop);
        category.setShop(shop);

        return categoryRepository.save(category);
    }

    @Override
    public List<Category> findCategoryByShopId(Long id) throws Exception {

        return categoryRepository.findByShopId(id);
    }

    @Override
    public Category findCategoryById(Long id) throws Exception {
        Optional<Category> optionalCategory = categoryRepository.findById(id);

        if (optionalCategory.isEmpty()) {
            throw new Exception("Category not found");
        }
        return optionalCategory.get();
    }
}

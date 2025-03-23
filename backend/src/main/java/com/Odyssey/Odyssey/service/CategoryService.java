package com.Odyssey.Odyssey.service;

import com.Odyssey.Odyssey.model.Category;

import java.util.List;

public interface CategoryService {

    public Category createCategory(String name, Long user_id);

    public List<Category> findCategoryByShopId(Long id) throws Exception;

    public Category findCategoryById(Long id) throws Exception;
}

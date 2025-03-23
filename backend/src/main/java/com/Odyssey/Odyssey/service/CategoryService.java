package com.Odyssey.Odyssey.service;

import com.Odyssey.Odyssey.model.Category;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface CategoryService {

    public Category createCategory(String name, Long user_id) throws Exception;

    public List<Category> findCategoryByShopId(Long id) throws Exception;

    public Category findCategoryById(Long id) throws Exception;
}

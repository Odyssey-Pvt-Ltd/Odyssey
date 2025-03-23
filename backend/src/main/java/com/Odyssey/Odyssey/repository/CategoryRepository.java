package com.Odyssey.Odyssey.repository;

import com.Odyssey.Odyssey.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CategoryRepository extends JpaRepository<Category, Long> {

    public List<Category> findByShopId(Long shopId);

}

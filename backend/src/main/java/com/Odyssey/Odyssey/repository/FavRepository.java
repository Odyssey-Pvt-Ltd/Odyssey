package com.Odyssey.Odyssey.repository;

import com.Odyssey.Odyssey.model.FavListing;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FavRepository extends JpaRepository<FavListing, Long> {
}
package com.Odyssey.Odyssey.repository;

import com.Odyssey.Odyssey.model.Listing;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ListingRepository extends JpaRepository<Listing, Long> {
    List<Listing> findByShopId(long shopId);

    @Query("SELECT f FROM Listing f WHERE f.title LIKE %:keyword% OR f.Listingcategory.name LIKE %:keyword%")
    List<Listing> searchListing(@Param("keyword") String keyword);
}

package com.Odyssey.Odyssey.service;

import com.Odyssey.Odyssey.Request.CreateListingRequest;
import com.Odyssey.Odyssey.model.Category;
import com.Odyssey.Odyssey.model.Listing;
import com.Odyssey.Odyssey.model.Shop;

import java.util.List;

public interface ListingService {
    public Listing CreatetListing(CreateListingRequest req, Category category, Shop shop);

    void DeleteListing(Long ListingId)throws Exception;

    public List<Listing>getShopsListing(Long shopId,String ListingCategory,boolean Active,boolean Inactive);
    public List<Listing>SearchListing(String keyword);
    public Listing findListingById(Long ListingId)throws Exception;
    public Listing updateListingAvailabilityStatus(Long listing_id)throws Exception;
}

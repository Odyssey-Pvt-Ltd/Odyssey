package com.Odyssey.Odyssey.service;

import com.Odyssey.Odyssey.Request.CreateListingRequest;
import com.Odyssey.Odyssey.model.Category;
import com.Odyssey.Odyssey.model.Listing;
import com.Odyssey.Odyssey.model.Shop;
import com.Odyssey.Odyssey.repository.ListingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ListingServiceImp implements ListingService {

    @Autowired
    private ListingRepository listingRepository;

    @Override
    public Listing CreatetListing(CreateListingRequest req, Category category, Shop shop) {
        Listing listing = new Listing();
        listing.setListingcategory(category);
        listing.setShop(shop);
        listing.setDescription(req.getDescription());
        listing.setImages(req.getImages());
        listing.setTitle(req.getTitle());
        listing.setPrice(req.getPrice());
        listing.setActive(true);
        Listing savedlisting=listingRepository.save(listing);
        shop.getItems().add(savedlisting);
        return savedlisting;
    }

    @Override
    public void DeleteListing(Long ListingId) throws Exception {
        Listing listing=findListingById(ListingId);
        listing.setShop(null);
        listingRepository.save(listing);
    }

    @Override
    public List<Listing> getShopsListing(Long shopId, String ListingCategory, boolean Active, boolean Inactive) {

        List<Listing>listings=listingRepository.findByShopId(shopId);

        if(Active){
         listings=filterByActive(listings,Active);
        }
        if(Inactive) {
            listings=filterByNonActive(listings,Inactive);
        }
        if(ListingCategory!=null && !ListingCategory.equals("")){
            listings=filterByCategory(listings,ListingCategory);
        }
        return listings;
    }

    private List<Listing> filterByCategory(List<Listing> listings, String listingCategory) {
        return listings.stream().filter(listing -> {
            if(listing.getListingcategory()!=null){
                return listing.getListingcategory().getName().equals(listingCategory);
            }
            return false;
        }).collect(Collectors.toList());
    }

    private List<Listing> filterByNonActive(List<Listing> listings, boolean inactive) {

        return listings.stream().filter(listing -> listing.isInactive()==false).collect(Collectors.toList());
    }

    private List<Listing> filterByActive(List<Listing> listings, boolean active) {
        return listings.stream().filter(listing -> listing.isActive()==active).collect(Collectors.toList());
    }

    @Override
    public List<Listing> SearchListing(String keyword) {
        return listingRepository.SearchListing(keyword);
    }

    @Override
    public Listing findListingById(Long ListingId) throws Exception {
        Optional<Listing> optionalListing=listingRepository.findById(ListingId);

        if(optionalListing.isEmpty()){
            throw new Exception("Listing not found");
        }
        return optionalListing.get();
    }

    @Override
    public Listing updateListingAvailabilityStatus(Long listing_id) throws Exception {
        Listing listing=findListingById(listing_id);
        listing.setActive(!listing.isActive());
        return listingRepository.save(listing);
    }
}

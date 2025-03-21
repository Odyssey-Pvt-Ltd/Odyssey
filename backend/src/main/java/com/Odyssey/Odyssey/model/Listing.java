package com.Odyssey.Odyssey.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.xml.stream.Location;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
public class Listing {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int listing_id;

    private String title;

    private String description;

    //private Location location;

    private Long price;

    @NotBlank(message = "Required listing type")
    private listing_type listing_type;

    @ManyToOne
    private Category Listingcategory;

    @Column(length = 1000)
    @ElementCollection
    private List<String> images;

    private boolean active;

    public int getListing_id() {
        return listing_id;
    }

    public void setListing_id(int listing_id) {
        this.listing_id = listing_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getPrice() {
        return price;
    }

    public void setPrice(Long price) {
        this.price = price;
    }

    public listing_type getListing_type() {
        return listing_type;
    }

    public void setListing_type(listing_type listing_type) {
        this.listing_type = listing_type;
    }

    public Category getListingcategory() {
        return Listingcategory;
    }

    public void setListingcategory(Category listingcategory) {
        Listingcategory = listingcategory;
    }

    public List<String> getImages() {
        return images;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public boolean isInactive() {
        return Inactive;
    }

    public void setInactive(boolean inactive) {
        Inactive = inactive;
    }

    public Shop getShop() {
        return shop;
    }

    public void setShop(Shop shop) {
        this.shop = shop;
    }

    private boolean Inactive;

    @ManyToOne
    @JoinColumn(name = "vendor_id", nullable = false)
    private Shop shop;

//    public void setPrice(Long price) {
//    }

//    public Category getListingcategory() {
//        return Listingcategory;
//    }
//
//    public void setListingcategory(Category listingcategory) {
//        Listingcategory = listingcategory;
//    }

}

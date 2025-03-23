package com.Odyssey.Odyssey.Request;

import com.Odyssey.Odyssey.model.Category;
import com.Odyssey.Odyssey.model.listing_type; // Ensure this import is correct
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.List;

@Data
public class CreateListingRequest {

    @NotBlank(message = "Title is required")
    private String title;

    @NotBlank(message = "Description is required")
    private String description;

    @NotNull(message = "Price is required")
    private Long price;

    @NotNull(message = "Category is required")
    private Category category;

    private List<String> images;

    @NotNull(message = "Shop ID is required")
    private Long shopID;

    private boolean active;

    private boolean inactive;

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

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public List<String> getImages() {
        return images;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }

    public Long getShopID() {
        return shopID;
    }

    public void setShopID(Long shopID) {
        this.shopID = shopID;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public boolean isInactive() {
        return inactive;
    }

    public void setInactive(boolean inactive) {
        this.inactive = inactive;
    }

    public listing_type getListing_type() {
        return listing_type;
    }

    public void setListing_type(listing_type listing_type) {
        this.listing_type = listing_type;
    }

    @NotNull(message = "Listing type is required")
    private listing_type listing_type; // Add this field and validate it with @NotNull
}
package com.Odyssey.Odyssey.Request;

import com.Odyssey.Odyssey.model.Category;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import  lombok.Data;

import java.util.List;

@Data
public class CreateListingRequest {

    @NotBlank(message = "Title is required")
    private String title;

    @NotBlank(message = "Description is required")
    private String description;

    @NotNull(message = "Price is required")
    private Long price;

    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    private Long categoryId;
    private List<String> images;

    private long shopID;
    private boolean active;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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



    public void setShopID(long shopID) {
        this.shopID = shopID;
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

    private boolean Inactive;

    public Long getShopID() {
        return shopID;
    }



    public String getDescription() {
        return description;
    }

    public List<String> getImages() {
        return images;
    }


}

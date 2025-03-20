package com.Odyssey.Odyssey.dto;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

import lombok.Data;
import java.util.List;


@Data
@Embeddable
public class ShopDTO {

    private String title;

//    @Column(length = 1000)
    private List<String> images;

    private String description;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    private Long id;




}

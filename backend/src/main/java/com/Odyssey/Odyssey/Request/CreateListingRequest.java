package com.Odyssey.Odyssey.Request;

import com.Odyssey.Odyssey.model.Category;
import  lombok.Data;

import java.util.List;

@Data
public class CreateListingRequest {

    private String title;
    private String description;
//    private String author;
    private Long price;

    private Category category;
    private List<String> images;

    private long shopID;
    private boolean active;
    private boolean Inactive;
}

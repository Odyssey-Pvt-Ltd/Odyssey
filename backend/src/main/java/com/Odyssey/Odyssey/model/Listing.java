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

    private int price;

    @NotBlank(message = "Required listing type")
    private listing_type listing_type;

    @ManyToOne
    private Category Listingcategory;

    @Column(length = 1000)
    @ElementCollection
    private List<String> images;

    private boolean active;

//    @ManyToOne
//    @JoinColumn(name = "vendor_id", nullable = false)
//    private Shop vendor;
}

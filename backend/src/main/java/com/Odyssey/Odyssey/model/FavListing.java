package com.Odyssey.Odyssey.model;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class FavListing {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @OneToOne
    private User customer;

    @OneToMany(mappedBy = "favListing" ,cascade = CascadeType.ALL, orphanRemoval = true)
    private List<FavItems> items = new ArrayList<>();
}

package com.Odyssey.Odyssey.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
public class Shop {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    private User owner;

    private String name;

    @OneToOne
    private String address;

    private String description;

    private String phone;

    private Boolean online;

    @JsonIgnore
    @OneToMany(mappedBy = "Shop" ,cascade = CascadeType.ALL)
    private List<Listing> items = new ArrayList<>();


}

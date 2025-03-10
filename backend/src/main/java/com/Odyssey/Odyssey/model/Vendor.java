package com.Odyssey.Odyssey.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name="vendors")
@Data
@AllArgsConstructor
@NoArgsConstructor

public class Vendor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private Long id;

    private String Name;

    private String Email;

    private String Phone;

    private String Address;

    @JsonIgnore
    @OneToMany
    private List<Listing> Listings=new ArrayList<>();

}

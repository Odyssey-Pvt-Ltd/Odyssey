//package com.Odyssey.Odyssey.model;
//
//import com.fasterxml.jackson.annotation.JsonIgnore;
////<<<<<<<< HEAD:backend/src/main/java/com/Odyssey/Odyssey/model/FavListing.java
//import jakarta.persistence.ManyToOne;
////========
//import jakarta.persistence.*;
////>>>>>>>> Binara:backend/src/main/java/com/Odyssey/Odyssey/model/Vendor.java
//import lombok.AllArgsConstructor;
//import lombok.Data;
//import lombok.NoArgsConstructor;
//import jakarta.persistence.*;
//
////<<<<<<<< HEAD:backend/src/main/java/com/Odyssey/Odyssey/model/FavListing.java
////========
//import java.util.ArrayList;
//import java.util.List;
//
//
//@Table(name="vendors")
////>>>>>>>> Binara:backend/src/main/java/com/Odyssey/Odyssey/model/Vendor.java
//@Data
//@AllArgsConstructor
//@NoArgsConstructor
//@Entity
//public class FavListing {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private Long id;
//
//    @ManyToOne
//    @JsonIgnore
//    private Fav fav;
//
//    @ManyToOne
//    private Listing listing;
//
//    @JsonIgnore
//    @OneToMany
//    private List<Listing> Listings=new ArrayList<>();
//
//}

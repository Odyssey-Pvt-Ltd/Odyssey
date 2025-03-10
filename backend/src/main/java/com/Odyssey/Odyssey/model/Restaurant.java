package com.Odyssey.Odyssey.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity

public class Restaurant {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long restaurant_id;

    public void setRestaurant_id(Long restaurantId) {
        this.restaurant_id = restaurantId;
    }

    public Long getRestaurant_id() {
        return restaurant_id;
    }
}

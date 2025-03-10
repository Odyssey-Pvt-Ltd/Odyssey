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

public class Hotel {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long hotel_id;

    public void setHotel_id(Long hotelId) {
        this.hotel_id = hotelId;
    }

    public Long getHotel_id() {
        return hotel_id;
    }
}

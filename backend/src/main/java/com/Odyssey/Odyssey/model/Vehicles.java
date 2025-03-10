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

public class Vehicles {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long vehicle_id;

    public void setVehicle_id(Long vehicleId) {
        this.vehicle_id = vehicleId;
    }

    public Long getVehicle_id() {
        return vehicle_id;
    }
}

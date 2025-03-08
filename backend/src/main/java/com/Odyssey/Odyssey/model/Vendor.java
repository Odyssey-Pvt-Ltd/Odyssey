package com.Odyssey.Odyssey.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

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

}

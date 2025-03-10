package com.Odyssey.Odyssey.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
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

    @NotBlank(message = "Name is required")
    private String Name;

    @NotBlank(message = "Email is required")
    @jakarta.validation.constraints.Email
    @Column(unique = true)
    private String Email;

    @NotBlank(message = "Phone Number is required")
    private String PhoneNumber;

    @NotBlank(message = "Address is required")
    private String Address;

    @NotBlank(message = "Password is required")
    private String password;

    @Transient
    @NotBlank(message = "Confirm Password is required")
    private String confirmPassword;

}

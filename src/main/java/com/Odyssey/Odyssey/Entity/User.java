package com.Odyssey.Odyssey.Entity;


import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "users")

public class User {

    @Id
    @GeneratedValue( Strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(massage = "Name is required")
    private String name;

    @NotBlank (massage = "Email is required")
    @Email
    @Column (unique = true)
    private String email;

    private String phoneNumber;

    @NotBlank(massahge = "password is required")
    private String password;

    @Transient
    @NotBlank
    private String confirmPassword;


}

package com.Odyssey.Odyssey.model;

import com.Odyssey.Odyssey.dto.ShopDTO;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Use IDENTITY for auto-increment
    @Column(name = "user_id")
    private Long id;

    @NotBlank(message = "Name is required")
    private String name;

    @NotBlank(message = "Email is required")
    @Email(message = "Invalid email format")
    @Column(unique = true, nullable = false)
    private String email;

    @NotBlank(message = "Phone number is required")
    private String phoneNumber;

    @NotBlank(message = "Address is required")
    private String address;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private USER_ROLE userType = USER_ROLE.ROLE_CUSTOMER; // Default role

    @NotBlank(message = "Password is required")
    private String password;

    @Transient // Not persisted in the database
    private String confirmPassword;

    @ElementCollection
    private List<ShopDTO> favorites = new ArrayList<>();

    public List<ShopDTO> getFavorites() {
        return favorites;
    }

    public void setFavorites(List<ShopDTO> favorites) {
        this.favorites = favorites;
    }
    
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public USER_ROLE getUserType() {
        return userType;
    }

    public void setUserType(USER_ROLE userType) {
        this.userType = userType;
    }

    public String getPassword() {
        return password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Listing> listings = new ArrayList<>();

    // Custom methods for password matching
    public boolean isPasswordConfirmed() {
        return password != null && password.equals(confirmPassword);
    }

    // Override Lombok's generated setPassword to encode the password
    public void setPassword(String password) {
        this.password = password;
    }



}
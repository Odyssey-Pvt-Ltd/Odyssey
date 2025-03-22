package com.Odyssey.Odyssey.model;


import com.Odyssey.Odyssey.dto.ShopDTO;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.*;

import java.util.List;
import java.util.ArrayList;




@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "users")
public class User {




    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "user_id")
    private Long id;



    @NotBlank(message = "Name is required")
    private String name;

    @NotBlank(message = "Email is required")
    @Email
    @Column(unique = true)
    private String email;


    @NotBlank(message = "Phone number required")
    private String phoneNumber;

//    @Getter
//    @Setter

    @NotBlank(message = "Address required")
    private String address;

//    @NotBlank(message = "user type required (vendor/customer)")
    @Enumerated(EnumType.STRING)
    private USER_ROLE userType;


//    @JsonIgnore
    @NotBlank(message = "Password is required")
    private String password;

    @Transient
    @NotBlank(message = "Confirm Password is required")
    private String confirmPassword;

    @Enumerated(EnumType.STRING)
    private USER_ROLE role = USER_ROLE.ROLE_CUSTOMER;

    public List<ShopDTO> getFavorites() {
        return favorites;
    }

    public void setFavorites(List<ShopDTO> favorites) {
        this.favorites = favorites;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long user_id) {
        this.id = user_id;
    }

    @ElementCollection
    private List<ShopDTO> favorites = new ArrayList<>();


    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)//cascade used for removal of all listings if removed (vendor)
    private List<Listing> Listings=new ArrayList<>();

    public USER_ROLE getRole() {
        return role;
    }

    public void setRole(USER_ROLE role) {
        this.role = role;
    }

//    @JsonIgnore
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

//    @JsonIgnore
    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName( String name) {
        this.name = name;
    }

    public USER_ROLE getUserType() {
        return userType;
    }

    public void setUserType(USER_ROLE userType) {
        this.userType = userType;
    }

    public @NotBlank(message = "Phone number required") String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(@NotBlank(message = "Phone number required") String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public @NotBlank(message = "Address required") String getAddress() {
        return address;
    }

    public void setAddress(@NotBlank(message = "Address required") String address) {
        this.address = address;
    }


}
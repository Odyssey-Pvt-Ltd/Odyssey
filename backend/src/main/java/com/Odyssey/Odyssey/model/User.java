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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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

    @NotBlank(message = "user type required (vendor/customer)")
    private user_type userType;


    @JsonIgnore
    @NotBlank(message = "Password is required")
    private String password;

    @Transient
    @NotBlank(message = "Confirm Password is required")
    private String confirmPassword;

    @ElementCollection
    private List<ShopDTO> favorites = new ArrayList<>();

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

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


}
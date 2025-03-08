package com.Odyssey.Odyssey.model;


import com.Odyssey.Odyssey.dto.ShopDTO;
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

    @Setter
    @Getter
    @NotBlank(message = "Email is required")
    @Email
    @Column(unique = true)
    private String email;

    private String phoneNumber;


    @Setter
    @Getter
    @NotBlank(message = "Password is required")
    private String password;

    @Setter
    @Getter
    @Transient
    @NotBlank(message = "Confirm Password is required")
    private String confirmPassword;

    @ElementCollection
    private List<ShopDTO> favorites = new ArrayList<>();


}
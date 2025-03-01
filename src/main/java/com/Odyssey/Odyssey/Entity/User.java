package com.Odyssey.Odyssey.Entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // Lombok will auto-generate getters, setters, equals, hashCode, and toString methods
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "user")
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

    private String phoneNumber;

    @NotBlank(message = "Password is required")
    private String password;

    @Transient
    @NotBlank(message = "Confirm Password is required")
    private String confirmPassword;

}

package com.Odyssey.Odyssey.dto;

import lombok.Data;

@Data
public class LoginRequest {
    private String email;
    private String password;

    // Manually added getters and setters in case Lombok is not working

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
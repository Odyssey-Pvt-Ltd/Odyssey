package com.Odyssey.Odyssey.controller;

import com.Odyssey.Odyssey.Entity.User;
import com.Odyssey.Odyssey.dto.LoginRequest;
import com.Odyssey.Odyssey.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder;  // Inject PasswordEncoder here

    @PostMapping("/register")
    public ResponseEntity<?> registerUser(@RequestBody User user) {
        if (!user.getPassword().equals(user.getConfirmPassword())) {
            return ResponseEntity.badRequest().body("Passwords do not match!");
        }

        if (userService.findByEmail(user.getEmail()).isPresent()) {
            return ResponseEntity.badRequest().body("Email is already in use!");
        }

        User registeredUser = userService.registerUser(user);
        return ResponseEntity.ok("User registered successfully!");
    }

    @PostMapping("/login")
    public ResponseEntity<?> loginUser(@RequestBody LoginRequest loginRequest) {
        return userService.findByEmail(loginRequest.getEmail())
                .filter(user -> passwordEncoder.matches(loginRequest.getPassword(), user.getPassword()))
                .map(user -> ResponseEntity.ok("Login successful!"))
                .orElse(ResponseEntity.status(401).body("Invalid credentials!"));
    }
}

package com.Odyssey.Odyssey.service;

import com.Odyssey.Odyssey.Entity.User;
import com.Odyssey.Odyssey.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.Optional;

public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public User registerUser(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        return userRepository.save(user);

    }

    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

}

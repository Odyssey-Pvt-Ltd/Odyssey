package com.Odyssey.Odyssey.service;

import com.Odyssey.Odyssey.model.USER_ROLE;
import com.Odyssey.Odyssey.model.User;
import com.Odyssey.Odyssey.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class CustomerUserDetailsService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        System.out.println("Searching for user with email: " + email);
        Optional<User> userOptional = userRepository.findByEmail(email);

        if (userOptional.isEmpty()) {
            System.out.println("User not found: " + email);
            throw new UsernameNotFoundException("User not found: " + email);
        }

        User user = userOptional.get();
        System.out.println("User found: " + user.getName());

        // Use getUserType() instead of getRole()
        USER_ROLE role = user.getUserType();

        List<GrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority(role.toString()));

        return new org.springframework.security.core.userdetails.User(
                user.getEmail(), // Use email as the username
                user.getPassword(),
                authorities
        );
    }
}
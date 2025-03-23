package com.Odyssey.Odyssey.controller;


import com.Odyssey.Odyssey.Request.LoginRequest;
import com.Odyssey.Odyssey.config.JwtProvider;
import com.Odyssey.Odyssey.model.FavListing;
import com.Odyssey.Odyssey.model.USER_ROLE;
import com.Odyssey.Odyssey.model.User;
import com.Odyssey.Odyssey.repository.FavRepository;
import com.Odyssey.Odyssey.repository.UserRepository;
import com.Odyssey.Odyssey.response.AuthResponse;
import com.Odyssey.Odyssey.service.CustomerUserDetailsService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collection;
import java.util.Optional;

@RestController
@RequestMapping("api/auth")
public class AuthController {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private JwtProvider jwtProvider;
    @Autowired
    private CustomerUserDetailsService customerUserDetailsService;
    @Autowired
    private FavRepository favRepository;

    @PostMapping("/signup")
    public ResponseEntity<AuthResponse> createUserHandler( @RequestBody User user) {

        System.out.println("Received user: " + user);

        Optional<User> isEmailExist = userRepository.findByEmail(user.getEmail());
        if (isEmailExist.isPresent()) {
            throw new RuntimeException("Email is already used");
        }

        if (!user.getPassword().equals(user.getConfirmPassword())) {
            throw new IllegalArgumentException("Password and Confirm Password do not match");
        }

        // Ensure userType is set before saving
        if (user.getUserType() == null) {
            user.setUserType(USER_ROLE.ROLE_CUSTOMER);
        }

        // Encode the password BEFORE saving
        if (user.getPassword() == null || user.getPassword().isBlank()) {
            throw new IllegalArgumentException("Password cannot be null or empty");
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));


        User savedUser = userRepository.save(user);

        // Create Favorite Listing for User
        FavListing favListing = new FavListing();
        favListing.setCustomer(savedUser);
        favRepository.save(favListing);

        // Authenticate user after signup
        Authentication authentication = new UsernamePasswordAuthenticationToken(user.getEmail(), user.getPassword());
        SecurityContextHolder.getContext().setAuthentication(authentication);

        // Generate JWT Token
        String jwt = jwtProvider.generateToken(authentication);

        // Build Response
        AuthResponse authResponse = new AuthResponse();
        authResponse.setJwt(jwt);
        authResponse.setMessage("Successfully registered and logged in");
        authResponse.setRole(savedUser.getUserType());

        return new ResponseEntity<>(authResponse, HttpStatus.OK);
    }


    @PostMapping("/SignIn")
    public ResponseEntity<AuthResponse> SignIn(@RequestBody LoginRequest loginRequest) {
        System.out.println("SignIn endpoint called with: " + loginRequest);

        String email = loginRequest.getEmail(); // Use email as the identifier
        String password = loginRequest.getPassword(); // Raw password

        Authentication authentication = authenticate(email, password);

        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        String role = authorities.isEmpty() ? null : authorities.iterator().next().getAuthority();

        String jwt = jwtProvider.generateToken(authentication);

        AuthResponse authResponse = new AuthResponse();
        authResponse.setJwt(jwt);
        authResponse.setMessage("Successfully logged in");
        authResponse.setRole(USER_ROLE.valueOf(role));

        return new ResponseEntity<>(authResponse, HttpStatus.OK);
    }

    private Authentication authenticate(String email, String password) {
        UserDetails userDetails = customerUserDetailsService.loadUserByUsername(email); // Use email to load user
        if (userDetails == null) {
            throw new BadCredentialsException("User not found");
        }
        System.out.println("Raw password from request: " + password);
        System.out.println("Hashed password from database: " + userDetails.getPassword());

        if (!passwordEncoder.matches(password, userDetails.getPassword())) {
            throw new BadCredentialsException("Wrong password");
        }
        return new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
    }


}

 /*   @Autowired
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

        // Encode the password before saving
        user.setPassword(passwordEncoder.encode(user.getPassword()));

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
}*/
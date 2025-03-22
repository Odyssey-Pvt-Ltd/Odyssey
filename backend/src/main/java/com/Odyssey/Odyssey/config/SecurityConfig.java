package com.Odyssey.Odyssey.config;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;

import java.util.Arrays;
import java.util.Collections;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http, CorsConfigurationSource corsConfigurationSource) throws Exception {
        http
                .sessionManagement(manager -> manager.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers("/api/auth/signup", "/api/auth/SignIn").permitAll() // Public endpoints
                        .requestMatchers("/api/user/profile").permitAll() // Public profile access
                        .requestMatchers("/api/admin/**").hasAnyRole("VENDOR", "ADMIN") // Restricted admin access
                        .requestMatchers("/api/**").authenticated() // Require authentication for API endpoints
                        .anyRequest().permitAll() // Allow all other requests
                )
                .csrf(csrf -> csrf.disable())
                .cors(cors -> cors.configurationSource(corsConfigurationSource))
                .addFilterBefore(new JwtTokenValidator(), BasicAuthenticationFilter.class);

        return http.build();
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        return request -> {
            CorsConfiguration cfg = new CorsConfiguration();
            cfg.setAllowedOrigins(Arrays.asList("http://localhost:3000")); // Allow requests from this origin
            cfg.setAllowedMethods(Collections.singletonList("*")); // Allow all HTTP methods
            cfg.setAllowedHeaders(Collections.singletonList("*")); // Allow all headers
            cfg.setAllowCredentials(true); // Allow credentials
            cfg.setExposedHeaders(Collections.singletonList("Authorization")); // Expose Authorization header
            cfg.setMaxAge(3600L); // Cache preflight response for 1 hour
            return cfg;
        };
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}

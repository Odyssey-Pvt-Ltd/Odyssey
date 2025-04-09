package com.Odyssey.Odyssey.config;

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
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .sessionManagement(manager -> manager.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers("/api/auth/").permitAll()
                        .requestMatchers("/api/chat").authenticated()
                        .requestMatchers("/api/category/").authenticated()
                        .requestMatchers("/api/admin/").hasAnyRole("VENDOR", "ADMIN")
                        .requestMatchers("/api/").authenticated()
                        .anyRequest().permitAll()
                )
                .csrf(csrf -> csrf.disable())
                .cors(cors -> cors.configurationSource(corsConfigurationSource())) // Enable CORS
                .addFilterBefore(new JwtTokenValidator(), BasicAuthenticationFilter.class);

        return http.build();
    }


    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        return request -> {
            CorsConfiguration cfg = new CorsConfiguration();
            cfg.addAllowedOriginPattern("*"); // ✅ Allow all origins for dev
            cfg.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS"));
            cfg.setAllowedHeaders(Arrays.asList("*")); // Accept all headers
            cfg.setAllowCredentials(true);
            cfg.setExposedHeaders(Arrays.asList("Authorization", "Content-Type"));
            cfg.setMaxAge(3600L);
            return cfg;
        };
    }



//    @Bean
//    public CorsConfigurationSource corsConfigurationSource() {
//        return request -> {
//            CorsConfiguration cfg = new CorsConfiguration();
//            cfg.setAllowedOrigins(Arrays.asList(
//                    "http://localhost:3000",
//                    "http://127.0.0.1:3000",
//                    "http://localhost:8080",
//                    "http://127.0.0.1:8080"
//            ));
//            cfg.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS"));
//            cfg.setAllowedHeaders(Arrays.asList("*"));
//            cfg.setAllowCredentials(true);
//            cfg.setExposedHeaders(Arrays.asList("Authorization", "Content-Type"));
//            cfg.setMaxAge(3600L);
//            return cfg;
//        };
//    }

//    @Bean
//    public CorsConfigurationSource corsConfigurationSource() {
//        return request -> {
//            CorsConfiguration cfg = new CorsConfiguration();
//            cfg.setAllowedOrigins(Arrays.asList("http://localhost:3000")); // Allow requests from this origin
//            cfg.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS")); // Allow specific HTTP methods
//            cfg.setAllowedHeaders(Arrays.asList("Authorization", "Content-Type")); // Allow specific headers
//            cfg.setAllowCredentials(true); // Allow credentials
//            cfg.setExposedHeaders(Collections.singletonList("Authorization")); // Expose Authorization header
//            cfg.setMaxAge(3600L); // Cache preflight response for 1 hour
//            return cfg;
//        };
//    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
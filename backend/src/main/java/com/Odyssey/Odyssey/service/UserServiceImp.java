package com.Odyssey.Odyssey.service;

import com.Odyssey.Odyssey.config.JwtProvider;

import com.Odyssey.Odyssey.model.User;
import com.Odyssey.Odyssey.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class UserServiceImp implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JwtProvider jwtProvider;

    @Override
    public User findUserByJwtToken(String jwt) throws Exception {

        String email = jwtProvider.getEmailFromJwt(jwt);

        User user = findUserByEmail(email);

        return user;
    }

    @Override
    public User findUserByEmail(String email) throws Exception {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new Exception("User not found"));
    }

}

package com.Odyssey.Odyssey.service;

import com.Odyssey.Odyssey.model.User;

public interface UserService {

    public User findUserByJwtToken(String jwt) throws Exception;

    public User findUserByEmail(String email) throws Exception;
}

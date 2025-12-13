package com.example.news_project.service;

import com.example.news_project.dto.auth.AuthenticateRequest;
import com.example.news_project.dto.auth.AuthenticateResponse;
import com.example.news_project.dto.user.UserResponse;

public interface AuthService {


    UserResponse register(AuthenticateRequest request);
    UserResponse login(Long id);


}

package com.example.news_project.dto.auth;

import com.example.news_project.dto.user.UserResponse;

import java.time.LocalDateTime;

public class AuthenticateResponse {

    public String token;
    public UserResponse user;

    public AuthenticateResponse(String token, UserResponse user) {
        this.user = user;
        this.token = token;
    }
}

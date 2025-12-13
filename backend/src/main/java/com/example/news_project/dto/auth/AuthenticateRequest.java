package com.example.news_project.dto.auth;

public class AuthenticateRequest {

    private String username;
    private String password;
    private String email;


    public String getPassword() {
        return password;
    }

    public String getUsername() {
        return username;
    }


    public String getEmail() {
        return email;
    }


}

package com.example.news_project.dto.user;

import com.example.news_project.model.enums.UserRole;

import java.time.LocalDateTime;

public class UserResponse {

    private Long id;
    private String username;
    private String email;
    private UserRole role;
    private LocalDateTime create_time;

    public UserResponse(Long id, String username, String email, UserRole role, LocalDateTime create_time) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.role = role;
        this.create_time = create_time;
    }

    public Long getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public UserRole getRole() {
        return role;
    }
}

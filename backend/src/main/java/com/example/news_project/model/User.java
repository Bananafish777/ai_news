package com.example.news_project.model;

import com.example.news_project.model.enums.UserRole;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.annotations.Type;

import jakarta.persistence.*;
import org.hibernate.type.SqlTypes;


import java.time.LocalDateTime;

@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 50, nullable = false)
    private String username;

    @Column(length = 254, nullable = false)
    private String email;

    @Column(name="password_hash", nullable = false, columnDefinition = "text")
    private String passwordHash;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(columnDefinition = "user_role", nullable = false)
    private UserRole role = UserRole.user;

    @Column(name = "is_deleted", nullable = false)
    private boolean isDeleted = Boolean.FALSE;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public UserRole getRole() {
        return role;
    }

    public void setRole(UserRole role) {
        this.role = role;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String password_hash) {
        this.passwordHash = password_hash;
    }

    public static User createUser(String username, String email, String password_hash) {
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPasswordHash(password_hash);
        user.setRole(UserRole.user);
        user.setCreatedAt(LocalDateTime.now());

        return user;
    }
}

package com.example.news_project.service.impl;

import com.example.news_project.dto.auth.AuthenticateRequest;
import com.example.news_project.dto.auth.AuthenticateResponse;
import com.example.news_project.dto.user.UserResponse;
import com.example.news_project.model.User;
import com.example.news_project.repository.UserRepository;
import com.example.news_project.security.JwtService;
import com.example.news_project.security.UserPrincipal;
import com.example.news_project.service.AuthService;
import jakarta.transaction.Transactional;

import java.util.Map;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthServiceImpl implements AuthService {

    private final UserRepository userRepository;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;
    private final PasswordEncoder passwordEncoder;

    public AuthServiceImpl(UserRepository userRepository, JwtService jwtService, AuthenticationManager authenticationManager, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.jwtService = jwtService;
        this.passwordEncoder = passwordEncoder;
        this.authenticationManager = authenticationManager;
    }

    private static UserResponse toDto(User user) {
        return new UserResponse(user.getId(), user.getUsername(), user.getEmail(), user.getRole(), user.getCreatedAt());
    }

    @Override @Transactional
    public UserResponse register(AuthenticateRequest req) {

        if(req.getUsername() == null || req.getUsername().isBlank()) throw new IllegalArgumentException("username can not be empty");
        if(req.getEmail() == null || req.getEmail().isBlank()) throw new IllegalArgumentException("email can not be empty");

        userRepository.findByEmailAndIsDeletedFalse(req.getEmail()).ifPresent(user -> { throw new IllegalArgumentException("email exists"); });
        userRepository.findByUsernameAndIsDeletedFalse(req.getUsername()).ifPresent(user -> { throw new IllegalArgumentException("username exists"); });

        User user = User.createUser(req.getUsername(), req.getEmail(), passwordEncoder.encode(req.getPassword()));
        userRepository.save(user);

        return toDto(user);
    }

    @Override
    public UserResponse login(Long id) {

        User user = userRepository.findByIdAndIsDeletedFalse(id).orElseThrow(() -> new IllegalArgumentException("user not found"));

        return toDto(user);
    }



}

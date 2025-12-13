package com.example.news_project.service.impl;

import com.example.news_project.dto.PageResponse;
import com.example.news_project.dto.user.UserCreateRequest;
import com.example.news_project.dto.user.UserResponse;
import com.example.news_project.dto.user.UserUpdateRequest;
import com.example.news_project.model.User;
import com.example.news_project.model.enums.UserRole;
import com.example.news_project.repository.UserRepository;
import com.example.news_project.security.JwtService;
import com.example.news_project.service.UserService;
import jakarta.transaction.Transactional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;


    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;

    }

    private UserResponse toDto(User user) {
        return new UserResponse(user.getId(), user.getUsername(), user.getEmail(), user.getRole(), user.getCreatedAt());
    }

    @Override @Transactional
    public UserResponse createUser(UserCreateRequest req) {

        if(req.getUsername() == null || req.getUsername().isBlank()) throw new IllegalArgumentException("username can not be empty");
        if(req.getEmail() == null || req.getEmail().isBlank()) throw new IllegalArgumentException("email can not be empty");

        userRepository.findByEmailAndIsDeletedFalse(req.getEmail()).ifPresent(user -> { throw new IllegalArgumentException("email exists"); });
        userRepository.findByUsernameAndIsDeletedFalse(req.getUsername()).ifPresent(user -> { throw new IllegalArgumentException("username exists"); });

        User user = User.createUser(req.getUsername(), req.getEmail(), req.getPassword());
        userRepository.save(user);
        return toDto(user);
    }

    @Override
    public PageResponse<UserResponse> getAllUsers(int page, int size) {
        int p = Math.max(0, page - 1); // 1基 -> 0基
        Pageable pageable = PageRequest.of(p, size, Sort.by(Sort.Direction.DESC, "createdAt"));
        Page<User> users = userRepository.findAllByIsDeletedFalse(pageable);

        List<UserResponse> items = users.getContent().stream()
                .map(this::toDto)
                .toList();

        return new PageResponse<>(items, page, size, users.getTotalElements());
    }


    @Transactional
    @Override
    public UserResponse updateProfile(UserUpdateRequest req, Long id) {
        User user = userRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("user not exists"));

        if(req.getUsername() != null && !req.getUsername().isBlank()) {
            user.setUsername(req.getUsername());
        }

        if(req.getEmail() != null && !req.getEmail().isBlank()) {
            user.setEmail(req.getEmail());
        }

        if(req.getPassword() != null && !req.getPassword().isBlank()) {
            user.setPasswordHash(req.getPassword());
        }

        return toDto(user);
    }

    @Transactional
    @Override
    public UserResponse updateRole(UserUpdateRequest req, Long id) {
        User user = userRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("user not exists"));
        updateProfile(req, id);
        if(req.getRole() != null && !req.getRole().isBlank()) {
            switch (req.getRole()) {
                case "admin":
                    user.setRole(UserRole.admin);
                    break;
                case "user":
                    user.setRole(UserRole.user);
                    break;
                case "editor":
                    user.setRole(UserRole.editor);
                    break;
            }
        }
        else{
            throw new IllegalArgumentException("role can not be empty");
        }

        userRepository.save(user);
        return toDto(user);
    }


    @Override
    public UserResponse getById(long id) {
        User user = userRepository.findByIdAndIsDeletedFalse(id).orElseThrow(() -> new IllegalArgumentException("user not found"));

        return toDto(user);
    }

    @Override
    public void deleteUser(long id) {
        if(id == 0) throw new IllegalArgumentException("id can not be empty");
        User user = userRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("user not found"));
        user.setDeleted(true);
        userRepository.save(user);

    }


}

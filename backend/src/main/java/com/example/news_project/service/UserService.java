package com.example.news_project.service;

import com.example.news_project.dto.PageResponse;
import com.example.news_project.dto.user.UserCreateRequest;
import com.example.news_project.dto.user.UserResponse;
import com.example.news_project.dto.user.UserUpdateRequest;
import org.springframework.data.domain.Page;

import java.util.List;

public interface UserService {

    //user
    UserResponse updateProfile(UserUpdateRequest req, Long id);
    UserResponse getById(long id);

    //admin
    UserResponse createUser(UserCreateRequest userRegisterRequest);
    PageResponse<UserResponse> getAllUsers(int page, int size);
    void deleteUser(long id);
    UserResponse updateRole(UserUpdateRequest req, Long id);


}

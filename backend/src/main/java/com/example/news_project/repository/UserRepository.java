package com.example.news_project.repository;

import com.example.news_project.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User,Long> {

    Optional<User> findByEmailAndIsDeletedFalse(String email);

    Optional<User> findByUsernameAndIsDeletedFalse(String username);

    Page<User> findAllByIsDeletedFalse(Pageable pageable);

    Optional<User> findByIdAndIsDeletedFalse(Long id);
}

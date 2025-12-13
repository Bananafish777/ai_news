package com.example.news_project.repository;

import com.example.news_project.model.Source;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface SourceRepository extends JpaRepository<Source, Long> {

    Optional<Source> findByName(String name);

    Optional<Source> findByIdAndIsDeletedFalse(Long id);

    List<Source> findAllByIsDeletedFalse();

}

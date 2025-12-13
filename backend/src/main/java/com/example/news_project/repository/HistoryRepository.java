package com.example.news_project.repository;

import com.example.news_project.model.History;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface HistoryRepository extends JpaRepository<History, Integer> {

    Optional<History> findByUserIdAndArticleId(Long userId, Long articleId);
}

package com.example.news_project.repository;

import com.example.news_project.model.Bookmark;
import com.example.news_project.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface BookmarkRepository extends JpaRepository<Bookmark, Long> {

    boolean existsByUserIdAndArticleIdAndIsDeletedFalse(Long userId, Long articleId);

    List<Bookmark> findByUserId(Long userId);

    Optional<Bookmark> findByUserAndArticleId(User user, Long article_id);

}

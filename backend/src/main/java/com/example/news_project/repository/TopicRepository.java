package com.example.news_project.repository;

import com.example.news_project.dto.topic.TopicResponse;
import com.example.news_project.model.Topic;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface TopicRepository extends JpaRepository<Topic, Long> {

    Optional<Topic> findByKeywordContainingIgnoreCaseAndIsDeletedFalse(String Keyword);

    Optional<Topic> findByIdAndIsDeletedFalse(Long id);

    List<Topic> findAllByIsDeletedFalse();

    @Query("""
        select new com.example.news_project.dto.topic.TopicResponse(t.id, t.keyword)
        from Topic t
        join t.articles a
        where a.id = :articleId and t.isDeleted = false and a.isDeleted = false
        order by lower(t.keyword)
    """)
    java.util.List<TopicResponse> findDtosByArticleId(@Param("articleId") Long articleId);
}

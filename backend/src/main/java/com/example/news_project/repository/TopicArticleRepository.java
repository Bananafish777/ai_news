package com.example.news_project.repository;

import com.example.news_project.model.TopicArticle;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TopicArticleRepository extends JpaRepository<TopicArticle, Long> {

    public TopicArticle findByTopicIdAndArticleId(Long topicId, Long articleId);
}

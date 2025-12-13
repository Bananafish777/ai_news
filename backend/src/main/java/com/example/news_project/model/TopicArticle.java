package com.example.news_project.model;

import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Entity
@Table(name = "topic_articles",
        indexes = {
                @Index(name = "idx_topic_articles_article", columnList = "article_id")
        })
public class TopicArticle {
    @EmbeddedId
    private TopicArticleId id;

    @ManyToOne(fetch = FetchType.LAZY) // ON DELETE CASCADE 由 DB 控制
    @MapsId("topicId")
    @JoinColumn(name = "topic_id",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_topic_articles_topic"))
    private Topic topic;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("articleId")
    @JoinColumn(name = "article_id",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_topic_articles_article"))
    private Article article;

    @Column(name = "assigned_at", nullable = false, updatable = false)
    @CreationTimestamp
    private LocalDateTime assignedAt;

    public TopicArticleId getId() {
        return id;
    }

    public void setId(TopicArticleId id) {
        this.id = id;
    }

    public Topic getTopic() {
        return topic;
    }

    public void setTopic(Topic topic) {
        this.topic = topic;
    }

    public Article getArticle() {
        return article;
    }

    public void setArticle(Article article) {
        this.article = article;
    }

    public LocalDateTime getAssignedAt() {
        return assignedAt;
    }

    public void setAssignedAt(LocalDateTime assignedAt) {
        this.assignedAt = assignedAt;
    }
    
    public static TopicArticle bindTopicArticle(Topic topic, Article article) {
        TopicArticle topicArticle = new TopicArticle();
        topicArticle.setTopic(topic);
        topicArticle.setArticle(article);
        topicArticle.setAssignedAt(LocalDateTime.now());
        return topicArticle;
    }
}


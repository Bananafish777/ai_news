package com.example.news_project.model;

import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;
import java.time.LocalDateTime;

@Embeddable
class HistoryId {
    @Column(name = "user_id")
    private Long userId;

    @Column(name = "article_id")
    private Long articleId;

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getArticleId() {
        return articleId;
    }

    public void setArticleId(Long articleId) {
        this.articleId = articleId;
    }
}

@Entity
@Table(name = "history",
        indexes = {
                @Index(name = "idx_history_user_last", columnList = "user_id, last_seen DESC")
        })
public class History {
    @EmbeddedId
    private HistoryId id;

    @ManyToOne(fetch = FetchType.LAZY) @MapsId("userId")
    @JoinColumn(name = "user_id",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_history_user"))
    private User user;

    @ManyToOne(fetch = FetchType.LAZY) @MapsId("articleId")
    @JoinColumn(name = "article_id",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_history_article"))
    private Article article;

    @Column(name = "first_seen", nullable = false, updatable = false)
    @CreationTimestamp
    private LocalDateTime firstSeen;

    @Column(name = "last_seen", nullable = false)
    @UpdateTimestamp
    private LocalDateTime lastSeen;

    public HistoryId getId() {
        return id;
    }

    public void setId(HistoryId id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Article getArticle() {
        return article;
    }

    public void setArticle(Article article) {
        this.article = article;
    }

    public LocalDateTime getFirstSeen() {
        return firstSeen;
    }

    public void setFirstSeen(LocalDateTime firstSeen) {
        this.firstSeen = firstSeen;
    }

    public LocalDateTime getLastSeen() {
        return lastSeen;
    }

    public void setLastSeen(LocalDateTime lastSeen) {
        this.lastSeen = lastSeen;
    }
}

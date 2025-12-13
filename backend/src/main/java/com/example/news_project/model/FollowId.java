package com.example.news_project.model;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

import java.util.Objects;

@Embeddable
public class FollowId {
    @Column(name = "user_id")
    private Long userId;

    @Column(name = "topic_id")
    private Long topicId;

    public FollowId() {
    }

    public FollowId(Long userId, Long topicId) {
        this.userId = userId;
        this.topicId = topicId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getTopicId() {
        return topicId;
    }

    public void setTopicId(Long topicId) {
        this.topicId = topicId;
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        FollowId followId = (FollowId) o;
        return Objects.equals(userId, followId.userId) && Objects.equals(topicId, followId.topicId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, topicId);
    }
}

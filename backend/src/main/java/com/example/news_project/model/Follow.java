package com.example.news_project.model;

import com.example.news_project.model.enums.NotificationLevel;
import com.example.news_project.model.enums.UserRole;
import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.LocalDateTime;
import java.time.LocalDateTime;

@Entity
@Table(name = "follows",
        indexes = {
                @Index(name = "idx_follows_user", columnList = "user_id")
        })

public class Follow {
    @EmbeddedId
    private FollowId id;

    @ManyToOne(fetch = FetchType.LAZY) @MapsId("userId")
    @JoinColumn(name = "user_id",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_follows_user"))
    private User user;

    @ManyToOne(fetch = FetchType.LAZY) @MapsId("topicId")
    @JoinColumn(name = "topic_id",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_follows_topic"))
    private Topic topic;

    @Column(name = "create_time", nullable = false, updatable = false)
    @CreationTimestamp
    private LocalDateTime createTime;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "notification_level", nullable = false)
    private NotificationLevel notificationLevel = NotificationLevel.site;

    public FollowId getId() {
        return id;
    }

    public void setId(FollowId id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Topic getTopic() {
        return topic;
    }

    public void setTopic(Topic topic) {
        this.topic = topic;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }

    public NotificationLevel getNotificationLevel() {
        return notificationLevel;
    }

    public void setNotificationLevel(NotificationLevel notificationLevel) {
        this.notificationLevel = notificationLevel;
    }

    public static Follow createFollow(User user, Topic topic) {
        Follow f = new Follow();
        f.id = new FollowId(user.getId(), topic.getId());   // ⭐⭐ 初始化复合主键
        f.user = user;
        f.topic = topic;
        f.createTime = LocalDateTime.now();
        return f;
    }
}


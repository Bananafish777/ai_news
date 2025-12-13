package com.example.news_project.dto.follow;

public class FollowerResponseLite {

    private Long userId;

    private String notification_level;

    public FollowerResponseLite(Long userId, String notification_level) {
        this.userId = userId;
        this.notification_level = notification_level;
    }

    public Long getUserId() {
        return userId;
    }

    public String getNotification_level() {
        return notification_level;
    }
}

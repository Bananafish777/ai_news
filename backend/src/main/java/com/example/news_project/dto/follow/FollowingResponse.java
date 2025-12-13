package com.example.news_project.dto.follow;

public class FollowingResponse {

    private Long id;
    private final String notification_level;

    public FollowingResponse(Long id, String notification_level) {
        this.id = id;
        this.notification_level = notification_level;

    }

    public Long getId() {
        return id;
    }

    public String getNotification_level() {return notification_level;}
}

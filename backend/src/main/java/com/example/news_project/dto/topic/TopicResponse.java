package com.example.news_project.dto.topic;

public class TopicResponse {

    private Long id;
    private String keywords;

    public TopicResponse(Long id, String keywords) {
        this.id = id;
        this.keywords = keywords;
    }

    public Long getId() {
        return id;
    }

    public String getKeywords() {
        return keywords;
    }
}

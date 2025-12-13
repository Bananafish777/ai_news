package com.example.news_project.dto.topic;

import java.util.List;

public class TopicPageResponse {

    private List<TopicResponse> topics;
    private int page;
    private int page_size;
    private int total;

    public List<TopicResponse> getTopics() {
        return topics;
    }

    public int getPage() {
        return page;
    }

    public int getPage_size() {
        return page_size;
    }

    public int getTotal() {
        return total;
    }
}

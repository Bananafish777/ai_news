package com.example.news_project.dto.source;

public class SourceResponse {

    private Long id;
    private String name;
    private String url;
    private String api;

    public SourceResponse(Long id, String name, String url, String api) {
        this.id = id;
        this.name = name;
        this.url = url;
        this.api = api;
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getUrl() {
        return url;
    }

    public String getApi() {
        return api;
    }
}

package com.example.news_project.dto.source;

import jakarta.validation.constraints.NotEmpty;

public class SourceCreateRequest {

    @NotEmpty
    private String name;
    @NotEmpty
    private String url;
    @NotEmpty
    private String api;

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

package com.example.news_project.dto.article;

public class ArticleContentResponse {

    private final String url;
    private final String content;

    public ArticleContentResponse(String url, String content) {
        this.url = url;
        this.content = content;
    }

    public String getUrl() {
        return url;
    }

    public String getContent() {
        return content;
    }
}

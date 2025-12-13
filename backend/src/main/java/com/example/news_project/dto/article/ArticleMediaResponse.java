package com.example.news_project.dto.article;

import com.example.news_project.model.enums.MediaType;

import javax.print.attribute.standard.Media;

public class ArticleMediaResponse {

    private final String url;
    private final String type;
    private final int size;

    public ArticleMediaResponse(String url, String type, int size) {
        this.url = url;
        this.type = type;
        this.size = size;
    }

    public String getUrl() {
        return url;
    }

    public String getType() {
        return type;
    }

    public int getSize() {
        return size;
    }
}

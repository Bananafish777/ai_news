package com.example.news_project.dto.article;

import com.example.news_project.dto.source.SourceResponseLite;

import java.time.LocalDateTime;

public class ArticleResponseLite {

    private Long id;
    private SourceResponseLite source;
    private String url;
    private String title;
    private String author;
    private LocalDateTime update_time;
    private ArticleMediaResponse cover;

    public ArticleResponseLite(Long i, SourceResponseLite source, String url, String title, String author, LocalDateTime update_time, ArticleMediaResponse cover) {
        this.id = i;
        this.source = source;
        this.cover = cover;
        this.url = url;
        this.title = title;
        this.author = author;
        this.update_time = update_time;
    }

    public Long getId() {
        return id;
    }

    public SourceResponseLite getSource() {
        return source;
    }

    public String getUrl() {
        return url;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthor() {
        return author;
    }

    public LocalDateTime getUpdate_time() {
        return update_time;
    }
}

package com.example.news_project.dto.bookmark;

import java.time.LocalDateTime;

public class BookmarkResponse {

    private Long articleId;
    private LocalDateTime createAt;

    public BookmarkResponse(Long articleId, LocalDateTime createAt) {
        this.articleId = articleId;
        this.createAt = createAt;
    }

    public Long getArticleId() {
        return articleId;
    }

    public LocalDateTime getCreateAt() {
        return createAt;
    }
}

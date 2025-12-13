package com.example.news_project.service;

import com.example.news_project.dto.PageResponse;
import com.example.news_project.dto.article.ArticleResponse;
import com.example.news_project.dto.article.ArticleResponseLite;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;


public interface ArticleService {

    public PageResponse<ArticleResponseLite> getPaged(int page, int size);
    public ArticleResponse getArticleById(Long id, Long currentUserId);
    public boolean modifyById(Long id, boolean hidden);
}

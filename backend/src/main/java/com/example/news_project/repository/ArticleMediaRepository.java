package com.example.news_project.repository;

import com.example.news_project.dto.article.ArticleMediaResponse;
import com.example.news_project.model.ArticleContent;
import com.example.news_project.model.ArticleMedia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface ArticleMediaRepository extends JpaRepository<ArticleMedia, Integer> {

    @Query("""
        select new com.example.news_project.dto.article.ArticleMediaResponse(m.url, cast(m.type as string), m.size)
        from ArticleMedia m
        where m.article.id = :articleId
        order by coalesce(m.position, 999999)
    """)
    java.util.List<ArticleMediaResponse> findDtosByArticleId(@Param("articleId") Long articleId);
}

package com.example.news_project.repository;

import com.example.news_project.dto.article.ArticleContentResponse;
import com.example.news_project.model.ArticleContent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface ArticleContentRepository extends JpaRepository<ArticleContent, Integer> {

    @Query("""
        select new com.example.news_project.dto.article.ArticleContentResponse(c.url, c.content)
        from ArticleContent c
        where c.article.id = :articleId
    """)
    Optional<ArticleContentResponse> findByArticleId(@Param("articleId") Long articleId);

    Optional<ArticleContent> getArticleContentByArticleId(long id);
}

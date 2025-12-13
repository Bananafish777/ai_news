package com.example.news_project.model;

import jakarta.persistence.*;

@Entity
@Table(name = "article_contents")
public class ArticleContent {
    @Id
    @Column(name = "article_id")
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @MapsId
    @JoinColumn(name = "article_id",
            foreignKey = @ForeignKey(name = "fk_article_contents_article"))
    private Article article;

    @Column(columnDefinition = "text")
    private String content;

    @Column(nullable = false, columnDefinition = "text")
    private String url; // 如与 articles.url 重复，可在应用层选择性使用

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Article getArticle() {
        return article;
    }

    public void setArticle(Article article) {
        this.article = article;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}

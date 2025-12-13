package com.example.news_project.model;

import com.example.news_project.model.enums.MediaType;
import jakarta.persistence.*;

@Entity
@Table(name = "article_medias",
        indexes = {
                @Index(name = "idx_media_article", columnList = "article_id")
        })
public class ArticleMedia {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "article_id",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_media_article"))
    private Article article;

    @Column(nullable = false, columnDefinition = "text")
    private String url;

    private Integer size;

    @Enumerated(EnumType.STRING)
    private MediaType type;

    @Column(columnDefinition = "text")
    private String reference;

    private Integer position;

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

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size;
    }

    public MediaType getType() {
        return type;
    }

    public void setType(MediaType type) {
        this.type = type;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public Integer getPosition() {
        return position;
    }

    public void setPosition(Integer position) {
        this.position = position;
    }
}


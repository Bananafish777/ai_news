package com.example.news_project.model;

import jakarta.persistence.*;

import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "topics")
public class Topic {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "text")
    private String keyword;

    @Column(name = "is_deleted", nullable = false)
    private boolean isDeleted = false;

    @ManyToMany
    @JoinTable(name = "topic_articles",
            joinColumns = @JoinColumn(name = "topic_id"),
            inverseJoinColumns = @JoinColumn(name = "article_id"))
    private Set<Article> articles = new HashSet<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    public static Topic createTopic(String keyword) {
        Topic topic = new Topic();
        topic.setKeyword(keyword);
        return topic;
    }
}

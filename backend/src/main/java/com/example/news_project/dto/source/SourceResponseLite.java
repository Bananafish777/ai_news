package com.example.news_project.dto.source;

public class SourceResponseLite {

    private Long id;
    private String name;


    public SourceResponseLite(Long id, String name) {
        this.id = id;
        this.name = name;

    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

}

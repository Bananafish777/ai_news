package com.example.news_project.dto.article;

import com.example.news_project.dto.bookmark.BookMarkStatusResponse;
import com.example.news_project.dto.history.HistoryResponse;
import com.example.news_project.dto.source.SourceResponseLite;
import com.example.news_project.dto.topic.TopicResponse;

import java.util.List;

public class ArticleResponse {

    private long id;
    private SourceResponseLite source;
    private String title;
    private String author;
    private List<ArticleContentResponse> content;
    private List<ArticleMediaResponse> media;
    private List<TopicResponse> topic;
    private BookMarkStatusResponse bookmark;
    private HistoryResponse  history;

    public ArticleResponse(long id, SourceResponseLite source, String title, String author, List<ArticleContentResponse> content, List<ArticleMediaResponse> media, List<TopicResponse> topic, BookMarkStatusResponse bookmark, HistoryResponse history) {
        this.id = id;
        this.source = source;
        this.title = title;
        this.author = author;
        this.content = content;
        this.media = media;
        this.topic = topic;
        this.bookmark = bookmark;
        this.history = history;
    }

    public long getId() {
        return id;
    }

    public SourceResponseLite getSource() {
        return source;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthor() {
        return author;
    }

    public List<ArticleContentResponse> getContent() {
        return content;
    }

    public List<ArticleMediaResponse> getMedia() {
        return media;
    }

    public List<TopicResponse> getTopic() {
        return topic;
    }

    public BookMarkStatusResponse getBookmark() {
        return bookmark;
    }

    public HistoryResponse getHistory() {
        return history;
    }
}

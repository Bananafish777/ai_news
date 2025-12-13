package com.example.news_project.service;

import com.example.news_project.dto.bookmark.BookmarkResponse;
import com.example.news_project.dto.follow.*;
import com.example.news_project.model.Bookmark;

import java.util.List;

public interface BookmarkService {
    

    public List<BookmarkResponse> getBookmarks(Long userId);

    public BookmarkResponse addBookmark(Long userId, Long articleId);

    public boolean deleteBookmark(Long userId, Long topicId);

}

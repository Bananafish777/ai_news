package com.example.news_project.dto.bookmark;

public class BookMarkStatusResponse {

    private boolean bookmarked;

    public BookMarkStatusResponse(boolean bookmarked) {
        this.bookmarked = bookmarked;
    }

    public boolean getBookmarked() { return bookmarked;  }
}

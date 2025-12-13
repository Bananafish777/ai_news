package com.example.news_project.dto.history;

import java.time.LocalDateTime;

public class HistoryResponse {

    private LocalDateTime first_seen;
    private LocalDateTime last_seen;

    public HistoryResponse(LocalDateTime first_seen, LocalDateTime last_seen) {
        this.first_seen = first_seen;
        this.last_seen = last_seen;
    }

    public LocalDateTime getFirst_seen() {
        return first_seen;
    }

    public LocalDateTime getLast_seen() {
        return last_seen;
    }
}

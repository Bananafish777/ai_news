package com.example.news_project.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;

public class PageResponse<T> {

    @JsonProperty("items")
    private List<T> items;

    @JsonProperty("page")
    private int page;

    @JsonProperty("page_size")
    private int pageSize;

    @JsonProperty("total")
    private long total;

    // 构造器
    public PageResponse(List<T> items, int page, int pageSize, long total) {
        this.items = items;
        this.page = page;
        this.pageSize = pageSize;
        this.total = total;
    }

    // ----- Getter / Setter -----

    public List<T> getItems() {
        return items;
    }

    public void setItems(List<T> items) {
        this.items = items;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }
}

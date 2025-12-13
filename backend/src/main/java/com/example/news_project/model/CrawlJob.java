package com.example.news_project.model;

import com.example.news_project.model.enums.CrawlStatus;
import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.Instant;

@Entity
@Table(name = "crawl_job")
public class CrawlJob {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "source_id",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_crawl_job_source"))
    private Source source;

    @Column(name = "start_time", nullable = false, updatable = false)
    @CreationTimestamp
    private Instant startTime;

    @Column(name = "end_time")
    private Instant endTime;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private CrawlStatus status = CrawlStatus.progressing;

    @Column(columnDefinition = "text")
    private String message;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Source getSource() {
        return source;
    }

    public void setSource(Source source) {
        this.source = source;
    }

    public Instant getStartTime() {
        return startTime;
    }

    public void setStartTime(Instant startTime) {
        this.startTime = startTime;
    }

    public Instant getEndTime() {
        return endTime;
    }

    public void setEndTime(Instant endTime) {
        this.endTime = endTime;
    }

    public CrawlStatus getStatus() {
        return status;
    }

    public void setStatus(CrawlStatus status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
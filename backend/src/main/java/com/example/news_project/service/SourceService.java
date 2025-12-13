package com.example.news_project.service;

import com.example.news_project.dto.source.SourceCreateRequest;
import com.example.news_project.dto.source.SourceResponse;
import com.example.news_project.dto.source.SourceUpdateRequest;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

public interface SourceService {

    SourceResponse createSource(@RequestBody SourceCreateRequest req);
    SourceResponse updateSource(@RequestBody SourceUpdateRequest req, long id);
    void deleteSource(long id);
    SourceResponse getSourceById(Long id);
    List<SourceResponse> getAllSources();
}

package com.example.news_project.service.impl;

import com.example.news_project.dto.source.SourceCreateRequest;
import com.example.news_project.dto.source.SourceResponse;
import com.example.news_project.dto.source.SourceUpdateRequest;
import com.example.news_project.model.Source;
import com.example.news_project.repository.SourceRepository;
import com.example.news_project.service.SourceService;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class SourceServiceImpl implements SourceService {
    
    private final SourceRepository sourceRepository;
    
    public SourceServiceImpl(SourceRepository sourceRepository) {
        this.sourceRepository = sourceRepository;
    }
    
    public static SourceResponse toDto(Source s) {
        return new SourceResponse(s.getId(), s.getName(), s.getUrl(), s.getApi());
    }
    
    @Override
    @Transactional
    public SourceResponse createSource(SourceCreateRequest req) {
        Source source = Source.createSource(req.getName(), req.getUrl(), req.getApi());
        sourceRepository.save(source);
        return toDto(source);
    }

    @Override
    public SourceResponse updateSource(SourceUpdateRequest req, long id) {
        Source source = sourceRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("Source not found"));

        if(req.getName() != null && !req.getName().isBlank()) {
            source.setName(req.getName());
        }

        if(req.getUrl() != null && !req.getUrl().isBlank()) {
            source.setUrl(req.getUrl());
        }

        if(req.getApi() != null && !req.getApi().isBlank()) {
            source.setApi(req.getApi());
        }
        source.setLastUpdate(LocalDateTime.now());

        sourceRepository.save(source);

        return toDto(source);
    
    }

    @Override
    public void deleteSource(long id) {

        Source source = sourceRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("Source not found"));
        source.setDeleteTime(LocalDateTime.now());
        source.setDeleted(true);
        sourceRepository.save(source);
    }

    @Override
    public SourceResponse getSourceById(Long id) {
        Source source = sourceRepository.findByIdAndIsDeletedFalse(id).orElseThrow(() -> new IllegalArgumentException("Source not found"));
        return toDto(source);
    }

    @Override
    public List<SourceResponse> getAllSources() {
        List<Source> sourceList = sourceRepository.findAllByIsDeletedFalse();
        List<SourceResponse> sourceResponses = new ArrayList<>();
        for (Source source : sourceList) {
            sourceResponses.add(toDto(source));
        }

        return sourceResponses;
    }
}

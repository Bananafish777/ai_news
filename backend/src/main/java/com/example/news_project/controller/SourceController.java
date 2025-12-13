package com.example.news_project.controller;

import com.example.news_project.dto.source.*;

import com.example.news_project.service.SourceService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/sources")
public class SourceController {
    
    SourceService service;

    public SourceController(SourceService service) {
        this.service = service;
    }

    @GetMapping()
    public ResponseEntity<List<SourceResponse>> getAllSource(){
        return ResponseEntity.ok(service.getAllSources());
    }

    @GetMapping("/{id}")
    public ResponseEntity<SourceResponse> getSourceById(@PathVariable Long id){
        return ResponseEntity.ok(service.getSourceById(id));
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping("/admin")
    public ResponseEntity<SourceResponse> createSource(@RequestBody SourceCreateRequest req){

        return ResponseEntity.ok(service.createSource(req));
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PatchMapping("/admin/{id}")
    public ResponseEntity<SourceResponse> updateSource(@PathVariable long id, @RequestBody SourceUpdateRequest req){
        return ResponseEntity.ok(service.updateSource(req, id));
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PatchMapping("/admin/delete/{id}")
    public ResponseEntity<Boolean> deleteSource(@PathVariable long id){
        service.deleteSource(id);
        return ResponseEntity.ok(Boolean.TRUE);
    }

}

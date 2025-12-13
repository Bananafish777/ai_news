package com.example.news_project.controller;

import com.example.news_project.dto.follow.FollowRequest;
import com.example.news_project.dto.topic.TopicCreateRequest;
import com.example.news_project.dto.topic.TopicResponse;
import com.example.news_project.dto.topic.TopicUpdateRequest;
import com.example.news_project.model.Follow;
import com.example.news_project.security.UserPrincipal;
import com.example.news_project.service.FollowService;
import com.example.news_project.service.TopicService;
import java.util.Map;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/topics")
public class TopicController {

    private final TopicService topicService;
    TopicService service;
    FollowService followService;

    public TopicController(TopicService service, FollowService followService, TopicService topicService) {
        this.service = service;
        this.followService = followService;
        this.topicService = topicService;
    }

    @GetMapping
    public ResponseEntity<List<TopicResponse>> getAllTopic(){
        return ResponseEntity.ok(service.getAllTopics());
    }

    @GetMapping("/{id}")
    public ResponseEntity<TopicResponse> getById(@PathVariable Long id){
        return ResponseEntity.ok(service.getTopicById(id));
    }


    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping("/admin/new")
    public ResponseEntity<TopicResponse> createTopic(@RequestBody TopicCreateRequest req){

        return ResponseEntity.ok(service.createTopic(req));
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PatchMapping("/admin/{id}")
    public ResponseEntity<TopicResponse> updateTopic(@RequestBody TopicUpdateRequest req, @PathVariable Long id){
        return ResponseEntity.ok(service.updateTopic(req, id));
    }

    @PreAuthorize("hasRole('ADMIN')")
    @DeleteMapping("/admin/delete/{id}")
    public ResponseEntity<Map<String, Boolean>> deleteTopic(@PathVariable Long id){

        service.deleteTopic(id);
        return ResponseEntity.ok(Map.of("success", true));
    }

    @PostMapping("/{id}/follow")
    public ResponseEntity<Follow> follow(@PathVariable Long id, @AuthenticationPrincipal UserPrincipal user, @RequestBody FollowRequest followReq){
        return ResponseEntity.ok(followService.follow(user.getId(), id, followReq.getNotification_level()));
    }

    @DeleteMapping("/{id}/unfollow")
    public ResponseEntity<Map<String, Boolean>> unfollow(@PathVariable Long id, @AuthenticationPrincipal UserPrincipal user){
        return ResponseEntity.ok(Map.of("success", followService.unfollow(user.getId(), id)));
    }

    @PostMapping("/admin/add/{id}/articles/{article_id}")
    public ResponseEntity<Map<String, Boolean>> bindArticleTopic(@PathVariable Long id, @PathVariable Long article_id){
        topicService.addArticleTopic(article_id, id);

        return ResponseEntity.ok(Map.of("success", true));
    }

    @PatchMapping("/admin/del/{id}/articles/{article_id}")
    public ResponseEntity<Map<String, Boolean>> unbindArticleTopic(@PathVariable Long id, @PathVariable Long article_id){
        topicService.delArticleTopic(article_id, id);

        return ResponseEntity.ok(Map.of("success", true));
    }

}

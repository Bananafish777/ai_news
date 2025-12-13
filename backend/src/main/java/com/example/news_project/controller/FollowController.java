package com.example.news_project.controller;


import com.example.news_project.dto.follow.FollowingResponse;
import com.example.news_project.model.Follow;
import com.example.news_project.security.UserPrincipal;
import com.example.news_project.service.FollowService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("api/follows")
public class FollowController {

    FollowService followService;

    public FollowController(FollowService followService) {
        this.followService = followService;
    }

    @GetMapping("/me")
    public ResponseEntity<List<FollowingResponse>> myFollows(@AuthenticationPrincipal UserPrincipal user) {
        return ResponseEntity.ok(followService.getFollowings(user.getId()));
    }
}

package com.example.news_project.service;

import com.example.news_project.dto.follow.*;
import com.example.news_project.model.Follow;

import java.util.List;

public interface FollowService {

    public List<FollowerResponseLite> getFollowers(Long topicId);

    public List<FollowingResponse> getFollowings(Long userId);

    public Follow follow(Long userId, Long topicId, String level);

    public boolean unfollow(Long userId, Long topicId);

}

package com.example.news_project.service.impl;

import com.example.news_project.dto.follow.FollowerResponseLite;
import com.example.news_project.dto.follow.FollowingResponse;
import com.example.news_project.dto.topic.TopicResponse;
import com.example.news_project.model.Follow;
import com.example.news_project.model.Topic;
import com.example.news_project.model.User;
import com.example.news_project.model.enums.NotificationLevel;
import com.example.news_project.repository.FollowRepository;
import com.example.news_project.repository.TopicRepository;
import com.example.news_project.repository.UserRepository;
import com.example.news_project.service.FollowService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FollowServiceImpl implements FollowService {

    FollowRepository repo;
    UserRepository userRepo;
    TopicRepository topicRepo;

    public FollowServiceImpl(FollowRepository repo, UserRepository userRepo, TopicRepository topicRepo) {
        this.repo = repo;
        this.userRepo = userRepo;
        this.topicRepo = topicRepo;
    }

    private FollowerResponseLite toFollower(Follow follow) {
        return new FollowerResponseLite(follow.getId().getUserId(), follow.getNotificationLevel().name());
    }

    private FollowingResponse toFollowing(Follow follow) {
        return new FollowingResponse(follow.getTopic().getId(), follow.getNotificationLevel().name());
    }


    @Override
    public List<FollowerResponseLite> getFollowers(Long topicId) {
        List<Follow> follows = repo.findByTopicId(topicId);

        return follows.stream().map(this::toFollower).toList();
    }

    @Override
    public List<FollowingResponse> getFollowings(Long userId) {
        List<Follow> follows = repo.findByUserId(userId);

        return follows.stream().map(this::toFollowing).toList();
    }

    @Override
    public Follow follow(Long userId, Long topicId, String level) {
        User user = userRepo.findByIdAndIsDeletedFalse(userId).orElseThrow(() -> new IllegalArgumentException("user not exists"));
        Topic topic = topicRepo.findByIdAndIsDeletedFalse(topicId).orElseThrow(() -> new IllegalArgumentException("topic not exists"));
        Follow follow = Follow.createFollow(user, topic);

        if (level == null) follow.setNotificationLevel(NotificationLevel.site);
        switch (level.trim().toLowerCase()) {
            case "message" :
                follow.setNotificationLevel(NotificationLevel.message);
                break;
            case "none":
                follow.setNotificationLevel(NotificationLevel.none);
                break;
            default:
                follow.setNotificationLevel(NotificationLevel.site);
        };

        repo.save(follow);

        return follow;
    }

    @Override
    public boolean unfollow(Long userId, Long topicId) {
        User user =  userRepo.findByIdAndIsDeletedFalse(userId).orElseThrow(() -> new IllegalArgumentException("user not exists"));

        Follow follow = repo.findByUserAndTopicId(user, topicId).orElseThrow(() -> new IllegalArgumentException("follow not exists"));
        repo.delete(follow);
        return true;
    }
}

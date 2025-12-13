package com.example.news_project.repository;


import com.example.news_project.model.Follow;
import com.example.news_project.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface FollowRepository extends JpaRepository<Follow,Long> {

    List<Follow> findByUserId(Long userId);

    List<Follow> findByTopicId(Long topicId);

    Optional<Follow> findByUserAndTopicId(User user, Long topic_id);
}

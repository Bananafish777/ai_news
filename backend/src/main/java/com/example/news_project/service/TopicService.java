package com.example.news_project.service;

import com.example.news_project.dto.topic.TopicCreateRequest;
import com.example.news_project.dto.topic.TopicResponse;
import com.example.news_project.dto.topic.TopicUpdateRequest;
import com.example.news_project.model.TopicArticle;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

public interface TopicService {

    TopicResponse createTopic(@RequestBody TopicCreateRequest req);
    TopicResponse updateTopic(@RequestBody TopicUpdateRequest req, Long id);
    void deleteTopic(Long id);
    TopicResponse getTopicById(Long id);
    List<TopicResponse> getAllTopics();

    void addArticleTopic(Long articleId, Long topicId);
    void delArticleTopic(Long articleId, Long topicId);
}

package com.example.news_project.service.impl;

import com.example.news_project.dto.topic.TopicCreateRequest;
import com.example.news_project.dto.topic.TopicResponse;
import com.example.news_project.dto.topic.TopicUpdateRequest;
import com.example.news_project.model.Article;
import com.example.news_project.model.Topic;
import com.example.news_project.model.TopicArticle;
import com.example.news_project.repository.ArticleRepository;
import com.example.news_project.repository.TopicArticleRepository;
import com.example.news_project.repository.TopicRepository;
import com.example.news_project.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TopicServiceImpl implements TopicService {

    private final TopicRepository topicRepo;
    private final TopicArticleRepository topicArticleRepo;
    private final ArticleRepository articleRepo;

    public TopicServiceImpl(TopicRepository topicRepo, ArticleRepository articleRepo, TopicArticleRepository topicArticleRepo) {
        this.topicRepo = topicRepo;
        this.topicArticleRepo = topicArticleRepo;
        this.articleRepo = articleRepo;
    }

    private TopicResponse toDto(Topic topic){
        return new TopicResponse(topic.getId(), topic.getKeyword());
    }


    @Override
    public TopicResponse createTopic(TopicCreateRequest req) {
        topicRepo.findByKeywordContainingIgnoreCaseAndIsDeletedFalse(req.getKeyword()).ifPresent(user -> { throw new IllegalArgumentException("topic exists"); });

        Topic topic = Topic.createTopic(req.getKeyword());
        topicRepo.save(topic);

        return toDto(topic);
    }

    @Override
    public TopicResponse updateTopic(TopicUpdateRequest req, Long id) {
        Topic topic = topicRepo.findByIdAndIsDeletedFalse(id).orElseThrow(() -> new IllegalArgumentException("topic not exists"));

        topic.setKeyword(req.getKeyword());
        topicRepo.save(topic);
        return toDto(topic);
    }

    @Override
    public void deleteTopic(Long id) {
        Topic topic = topicRepo.findByIdAndIsDeletedFalse(id).orElseThrow(() -> new IllegalArgumentException("topic not exists"));


        topicRepo.delete(topic);

    }

    @Override
    public TopicResponse getTopicById(Long id) {
        Topic topic = topicRepo.findByIdAndIsDeletedFalse(id).orElseThrow(() -> new IllegalArgumentException("topic not exists"));

        return toDto(topic);
    }

    @Override
    public List<TopicResponse> getAllTopics() {
        List<Topic> topics = topicRepo.findAllByIsDeletedFalse();

        return topics.stream().map(this::toDto).toList();
    }

    @Override
    public void addArticleTopic(Long articleId, Long topicId) {
        Article a = articleRepo.findById(articleId).orElseThrow(() -> new IllegalArgumentException("article not exists"));
        Topic t = topicRepo.findById(topicId).orElseThrow(() -> new IllegalArgumentException("topic not exists"));

        TopicArticle topicArticle = TopicArticle.bindTopicArticle(t, a);
        topicArticleRepo.save(topicArticle);

    }

    @Override
    public void delArticleTopic(Long articleId, Long topicId) {
        TopicArticle ta = topicArticleRepo.findByTopicIdAndArticleId(topicId, articleId);
        topicArticleRepo.delete(ta);
    }
}

package com.example.news_project.service.impl;

import com.example.news_project.dto.PageResponse;
import com.example.news_project.dto.article.ArticleMediaResponse;
import com.example.news_project.dto.article.ArticleResponse;
import com.example.news_project.dto.article.ArticleResponseLite;
import com.example.news_project.dto.bookmark.BookMarkStatusResponse;
import com.example.news_project.dto.history.HistoryResponse;
import com.example.news_project.dto.source.SourceResponseLite;
import com.example.news_project.dto.user.UserResponse;
import com.example.news_project.model.Article;
import com.example.news_project.model.Source;
import com.example.news_project.repository.*;
import com.example.news_project.service.ArticleService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.NoSuchElementException;

@Service
public class ArticleServiceImpl implements ArticleService {
    private final ArticleRepository articleRepo;
    private final ArticleContentRepository contentRepo;
    private final ArticleMediaRepository mediaRepo;
    private final TopicRepository topicRepo;
    private final BookmarkRepository bookmarkRepo;
    private final HistoryRepository historyRepo;

    public ArticleServiceImpl(ArticleRepository articleRepo, ArticleContentRepository contentRepo, ArticleMediaRepository mediaRepo, TopicRepository topicRepo, BookmarkRepository bookmarkRepo, HistoryRepository historyRepo) {
        this.articleRepo = articleRepo;
        this.contentRepo = contentRepo;
        this.mediaRepo = mediaRepo;
        this.topicRepo = topicRepo;
        this.bookmarkRepo = bookmarkRepo;
        this.historyRepo = historyRepo;
    }

    public SourceResponseLite toSource(Source s) {
        return new SourceResponseLite(s.getId(), s.getName());
    }

    public ArticleResponseLite toDtoLite(Article article) {
        return new  ArticleResponseLite(article.getId(), toSource(article.getSource()), article.getUrl(), article.getTitle(), article.getAuthor(), article.getLastUpdate(), null);
    }

    @Transactional(readOnly = true)
    public ArticleResponse getArticleById(Long articleId, Long currentUserId) {
        var a = articleRepo.findByIdAndIsDeletedFalse(articleId)
                .orElseThrow(() -> new NoSuchElementException("Article not found"));

        // source
        var sourceDTO = new SourceResponseLite(a.getSource() != null ? a.getSource().getId() : null,
                a.getSource() != null ? a.getSource().getName() : null);

        // content（1:1 → 数组包装）
        var contentDTO = contentRepo.findByArticleId(articleId)
                .map(java.util.List::of)
                .orElseGet(java.util.List::of);

        // medias
        var medias = mediaRepo.findDtosByArticleId(articleId);

        // topics
        var topics = topicRepo.findDtosByArticleId(articleId);

        // 用户态（未登录就跳过）
        BookMarkStatusResponse bm = new BookMarkStatusResponse(false);
        HistoryResponse hs = null;

        if (currentUserId != null) {
            boolean bookmarked = bookmarkRepo.existsByUserIdAndArticleIdAndIsDeletedFalse(currentUserId, articleId);
            bm = new BookMarkStatusResponse(bookmarked);

            var hOpt = historyRepo.findByUserIdAndArticleId(currentUserId, articleId);
            if (hOpt.isPresent()) {
                var h = hOpt.get();
                hs = new HistoryResponse(h.getFirstSeen(), h.getLastSeen());
            } else {
                hs = null;
            }
        }

        return new ArticleResponse(
                a.getId(),
                sourceDTO,
                a.getTitle(),
                a.getAuthor(),
                contentDTO,
                medias,
                topics,
                bm,
                hs
        );
    }

//    @Override
//    public Page<ArticleResponseLite> getPaged(int page, int size) {
//        int p = page - 1;
//
//        Pageable pageable = PageRequest.of(p, size);
//        Page<ArticleResponseLite> articles = articleRepo.pageRaw(pageable);
//
//        List<ArticleResponseLite> list = articles.getContent().stream().toList();
//
//        return null;
//    }

    @Override
    public boolean modifyById(Long id, boolean hidden){
        Article article = articleRepo.findById(id).orElseThrow(() -> new NoSuchElementException("Article not found"));
        article.setDeleted(hidden);
        article.setDeleteTime(LocalDateTime.now());

        articleRepo.save(article);
        return true;
    }

    public PageResponse<ArticleResponseLite> getPaged(int page, int size) {
        int p = page - 1;
        Pageable pageable = PageRequest.of(p, size);
        Page<Object[]> rows = articleRepo.paged(pageable);

        List<ArticleResponseLite> items = rows.getContent().stream()
                .map(this::toLiteDto)   // 见下方方法
                .toList();

        return new PageResponse<>(items, page, size, rows.getTotalElements());
    }

    private ArticleResponseLite toLiteDto(Object[] r) {
        // 列顺序与 SQL 一一对应：
        // 0:id, 1:source_id, 2:source_name, 3:url, 4:title, 5:author,
        // 6:last_update, 7:cover_url, 8:cover_size

        Long id          = n2l(r[0]);
        Long sourceId    = n2l(r[1]);
        String sourceName= (String) r[2];
        String url       = (String) r[3];
        String title     = (String) r[4];
        String author    = (String) r[5];
        LocalDateTime upd= toLdt(r[6]);
        String coverUrl  = (String) r[7];
        Integer coverSz  = n2i(r[8]);  // 可能为 null

        SourceResponseLite source = new SourceResponseLite(sourceId, sourceName);


        return new ArticleResponseLite(id, source, url, title, author, upd, null);
    }

    // —— 小工具：安全转换数字/时间（避免 BigInteger/Null 拆箱 NPE） ——
    private static Long n2l(Object o) {
        return o == null ? null : ((Number) o).longValue();
    }

    private static Integer n2i(Object o) {
        return o == null ? null : ((Number) o).intValue();
    }

    private static LocalDateTime toLdt(Object o) {
        if (o == null) return null;
        if (o instanceof LocalDateTime ldt) return ldt;
        if (o instanceof java.sql.Timestamp ts) return ts.toLocalDateTime();
        throw new IllegalStateException("Unexpected time type: " + o.getClass());
    }



}

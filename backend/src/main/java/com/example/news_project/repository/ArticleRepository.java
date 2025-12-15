package com.example.news_project.repository;

import com.example.news_project.dto.article.ArticleResponse;
import com.example.news_project.dto.article.ArticleResponseLite;
import com.example.news_project.model.Article;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;



public interface ArticleRepository extends JpaRepository<Article, Long> {

    @Query(
            value = """
    select
      a.id                            as id,
      s.id                            as source_id,
      s.name                          as source_name,
      a.url                           as url,
      a.title                         as title,
      a.author                        as author,
      a.last_update                   as last_update,
      m1.url                          as cover_url,
      m1.size                         as cover_size
    from articles a
    join sources s on s.id = a.source_id
    left join lateral (
      select m.url, m.size
      from article_medias m
      where m.article_id = a.id
        and m.type = 'cover'
      order by m.position nulls last
      limit 1
    ) m1 on true
    where not a.is_deleted and not s.is_deleted
    order by a.last_update desc, a.id desc
  """,
            countQuery = """
    select count(*)
    from articles a
    join sources s on s.id = a.source_id
    where not a.is_deleted and not s.is_deleted
  """,
            nativeQuery = true
    )
    Page<ArticleResponseLite> pageRaw(Pageable pageable);


    @Query(
            value = """
select
  a.id                            as id,
  s.id                            as source_id,
  s.name                          as source_name,
  a.url                           as url,
  a.title                         as title,
  a.author                        as author,
  a.last_update                   as last_update,
  m1.url                          as cover_url,
  m1.size                         as cover_size
from articles a
join sources s on s.id = a.source_id
left join lateral (
  select m.url, m.size
  from article_medias m
  where m.article_id = a.id
    and m.type = 'cover'
  order by m.position nulls last
  limit 1
) m1 on true
where not a.is_deleted and not s.is_deleted
order by a.last_update desc, a.id desc
""",
            countQuery = """
select count(*)
from articles a
join sources s on s.id = a.source_id
where not a.is_deleted and not s.is_deleted
""",
            nativeQuery = true
    )
    Page<Object[]> paged(Pageable pageable);

    @Query(
            value = """
select
  a.id                            as id,
  s.id                            as source_id,
  s.name                          as source_name,
  a.url                           as url,
  a.title                         as title,
  a.author                        as author,
  a.last_update                   as last_update,
  m1.url                          as cover_url,
  m1.size                         as cover_size
from articles a
join sources s on s.id = a.source_id
left join lateral (
  select m.url, m.size
  from article_medias m
  where m.article_id = a.id
    and m.type = 'cover'
  order by m.position nulls last
  limit 1
) m1 on true
where not a.is_deleted and not s.is_deleted
order by a.last_update desc, a.id desc
""",
            countQuery = """
select count(*)
from articles a
join sources s on s.id = a.source_id
where not a.is_deleted and not s.is_deleted
""",
            nativeQuery = true
    )
    Page<Object[]> getByTopic(Pageable pageable);


    Optional<Article> findByIdAndIsDeletedFalse(long id);
}


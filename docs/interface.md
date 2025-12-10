````markdown
# 新闻网站接口文档（API Specification）

## 全局约定

- 基础路径：`/api`
- 所有接口使用 JSON：
  - `Content-Type: application/json; charset=utf-8`
- 认证方式：
  - 登录后返回 `token`（对应 TOKENS.token_hash）
  - 后续请求头需携带：
    ```
    Authorization: Bearer <token>
    ```
- 时间格式：
  - 使用 ISO8601，例如 `2025-12-10T12:34:56Z`
- 分页参数：
  - `page`（从 1 开始）
  - `page_size`
  - 返回体需包含 `total`

---

# 1. 用户与认证 AUTH / USERS

## 1.1 注册

**POST** `/auth/register`

**请求体**

```json
{
  "username": "test_user",
  "password": "123456",
  "email": "test@example.com"
}
````

**响应**

```json
{
  "user": {
    "id": 1,
    "username": "test_user",
    "email": "test@example.com",
    "role": "user(editor, admin)", 
    "create_time": "2025-12-10T12:00:00Z"
  }
}
```

---

## 1.2 登录

**POST** `/auth/login`

**请求体**

```json
{
  "username": "test_user",
  "password": "123456"
}
```

**响应**

```json
{
  "token": "xxxxxx",
  "user": {
    "id": 1,
    "username": "test_user",
    "email": "test@example.com",
    "role": "user"
  }
}
```

---

## 1.3 退出登录

**POST** `/auth/logout`

**响应**

```json
{ "success": true }
```

---

## 1.4 获取当前用户信息

**GET** `user/me`

**响应**

```json
{
  "id": 1,
  "username": "test_user",
  "email": "test@example.com",
  "role": "user",
  "create_time": "2025-12-10T12:00:00Z"
}
```

---

## 1.5 用户管理（管理员）

### 获取用户列表

**GET** `/user/admin?page=1&page_size=20`

**响应**

```json
{
  "items": [
    {
      "id": 1,
      "username": "test_user",
      "email": "test@example.com",
      "role": "user",
      "create_time": "2025-12-10T12:00:00Z"
    }
  ],
  "page": 1,
  "page_size": 20,
  "total": 1
}
```

### 更新用户

**PATCH** `/user/admin/{user_id}`

**请求体**

```json
{
  "id": 1,
  "username": "test_user",
  "email": "test@example.com",
  "role": "user"
}
```

**响应**

```json
{
  "id": 1,
  "username": "test_user",
  "email": "test@example.com",
  "role": "user"
}
```

---

# 2. 新闻源 SOURCE

## 2.1 获取新闻源列表（公开）

**GET** `/sources`

**响应**

```json
{
  "items": [
    {
      "id": 1,
      "name": "New York Times",
      "url": "https://nytimes.com",
      "api": "https://api.nytimes.com/...",
      "enabled": true,
      "last_update": "2025-12-10T11:00:00Z"
    }
  ]
}
```

---

## 2.2 获取单个新闻源

**GET** `/sources/{id}`

---

## 2.3 管理新闻源（管理员）

* 新建：`POST /sources/admin`
* 更新：`PATCH /sources/admin/{id}`
* 删除：`PATCH /sources/admin/delete/{id}`（软删）

**POST 示例**

```json
{
  "name": "New York Times",
  "url": "https://nytimes.com",
  "api": "https://api.nytimes.com",
  "enabled": true
}
```

---

# 3. 文章 ARTICLE / ARTICLE_CONTENT / ARTICLE_MEDIA

## 3.1 获取文章列表

**GET** `/articles?page=1&page_size=20`

支持参数：

* `source_id`
* `topic_id`
* `keyword`
* `order=latest|popular`

**响应**

```json
{
  "items": [
    {
      "id": 100,
      "source": { "id": 1, "name": "New York Times" },
      "url": "https://nytimes.com/xxx",
      "title": "Some News",
      "author": "John Doe",
      "description": "Short summary...",
      "update_time": "2025-12-10T10:00:00Z"
    }
  ],
  "page": 1,
  "page_size": 20,
  "total": 2000
}
```

---

## 3.2 获取文章详情（含正文/媒体/主题）

**GET** `/articles/{id}`

**响应**

```json
{
  "id": 100,
  "source": { "id": 1, "name": "New York Times" },
  "url": "https://nytimes.com/xxx",
  "title": "Some News",
  "author": "John Doe",
  "description": "Short summary...",
  "content": [
    { "url": "https://nytimes.com/xxx", "content": "Full HTML/markdown..." }
  ],
  "media": [
    { "url": "https://nytimes.com/img.jpg", "type": "cover(thumbnail, image, video)", "size": 12345 }
  ],
  "topics": [
    { "id": 10, "keywords": "AI, Machine Learning" }
  ],
  "bookmark_status": { "bookmarked": true },
  "history_status": {
    "first_seen": "2025-12-10T10:05:00Z",
    "last_seen": "2025-12-10T10:05:00Z"
  }
}
```

---

## 3.3 管理文章（管理员）

* 列表：`GET /articles/admin`
* 修改隐藏状态：`PATCH /articles/admin/{id}`

```json
{
  "is_hidden": true
}
```

---

# 4. 主题 TOPICS 与关联 TOPIC_ARTICLE

## 4.1 获取主题列表

**GET** `/topics`

**响应**

```json
{
  "items": [
    { "id": 10, "keywords": "AI, Machine Learning"}
  ],
  "page": 1,
  "page_size": 20,
  "total": 50
}
```

---

## 4.2 获取主题详情（含文章）

**GET** `/topics/{id}`

---

## 4.3 主题管理（管理员）

* 新建主题：`POST /topics/admin/new`
* 更新主题：`PATCH /topics/admin/{id}`
* 删除主题：`DELETE /topics/admin/delete/{id}`
* 添加文章到主题：`POST /topics/admin/add/{id}/articles/{article_id}`
* 移除文章：`PATCH /topics/admin/del/{id}/articles/{article_id}`

---

# 5. 关注主题 FOLLOWS

## 5.1 关注主题

**POST** `/topics/{id}/follow`

```json
{
  "notification_level": "email"
}
```

---

## 5.2 取消关注主题

**DELETE** `/topics/{id}/unfollow`

---

## 5.3 获取我的关注列表

**GET** `/follows/me`

---

# 6. 收藏 BOOKMARK 与历史 HISTORY

## 6.1 收藏文章

**POST** `bookmark/add/{article_id}`

---

## 6.2 取消收藏

**DELETE** `/bookmark/del/{article_id}`

---

## 6.3 获取收藏列表

**GET** `/bookmarks/me`

---

## 6.4 获取阅读历史

**GET** `history/me`

---

# 7. 抓取任务 CRAWL_JOB（运维）

## 7.1 获取抓取任务列表

**GET** `/crawl_jobs/admins`

---

## 7.2 创建抓取任务

**POST** `/crawl_jobs/admin`

```json
{ "source_id": 1 }
```

---

## 7.3 获取任务详情

**GET** `/crawl_jobs/admin/{id}`

---

# 8. TOKENS（会话管理）

## 8.1 获取用户 Token 列表（管理员）

**GET** `/tokens/admin/user/{user_di}`

---

## 8.2 强制失效 Token

**PATCH** `/tokens/admin/{token_hash}`

---

常见错误码：

| code             | 含义            |
| ---------------- | ------------- |
| UNAUTHORIZED     | 未登录或 token 失效 |
| FORBIDDEN        | 权限不足          |
| NOT_FOUND        | 资源不存在         |
| VALIDATION_ERROR | 参数错误          |
| INTERNAL_ERROR   | 服务端异常         |

---

# 10. AI 功能（Google Gemini 集成）

## 10.1 AI 新闻摘要生成

**POST** `/ai/summarize`

**说明**：使用 Google Gemini API 为指定文章生成智能摘要

**请求体**

```json
{
  "article_id": 100,
  "max_length": 200,
  "language": "zh-CN"
}
```

**响应**

```json
{
  "article_id": 100,
  "summary": "这是一篇关于人工智能最新发展的新闻报道，主要介绍了...",
  "model": "gemini-pro",
  "generated_at": "2025-12-10T12:30:00Z"
}
```

---

## 10.2 AI 主题分类

**POST** `/ai/classify`

**说明**：使用 Google Gemini API 自动分析文章并推荐相关主题

**请求体**

```json
{
  "article_id": 100,
  "candidate_topics": [10, 11, 12]
}
```

**响应**

```json
{
  "article_id": 100,
  "suggested_topics": [
    {
      "topic_id": 10,
      "keywords": "AI, Machine Learning",
      "confidence": 0.95
    },
    {
      "topic_id": 11,
      "keywords": "Technology, Innovation",
      "confidence": 0.87
    }
  ],
  "model": "gemini-pro",
  "generated_at": "2025-12-10T12:30:00Z"
}
```

---

## 10.3 AI 智能问答

**POST** `/ai/chat`

**说明**：基于文章内容进行对话式问答

**请求体**

```json
{
  "article_id": 100,
  "question": "这篇文章的主要观点是什么？",
  "conversation_id": "uuid-1234",
  "history": [
    {
      "role": "user",
      "content": "文章提到了哪些公司？"
    },
    {
      "role": "assistant",
      "content": "文章提到了 Google、Microsoft 和 OpenAI。"
    }
  ]
}
```

**响应**

```json
{
  "conversation_id": "uuid-1234",
  "response": "这篇文章的主要观点是...",
  "model": "gemini-pro",
  "generated_at": "2025-12-10T12:30:00Z",
  "tokens_used": {
    "prompt": 1200,
    "completion": 150,
    "total": 1350
  }
}
```

---

## 10.4 AI 内容推荐

**GET** `/ai/recommend`

**说明**：基于用户阅读历史和兴趣，使用 AI 推荐相关文章

**请求参数**

* `user_id`: 用户 ID（可选，默认当前用户）
* `limit`: 推荐数量（默认 10）
* `exclude_read`: 是否排除已读文章（默认 true）

**响应**

```json
{
  "recommendations": [
    {
      "article_id": 101,
      "title": "AI 技术的未来趋势",
      "score": 0.92,
      "reason": "基于您对人工智能和机器学习的兴趣"
    },
    {
      "article_id": 102,
      "title": "深度学习在医疗领域的应用",
      "score": 0.88,
      "reason": "与您最近阅读的文章相似"
    }
  ],
  "model": "gemini-pro",
  "generated_at": "2025-12-10T12:30:00Z"
}
```

---

## 10.5 AI 情感分析

**POST** `/ai/sentiment`

**说明**：分析文章的情感倾向和语气

**请求体**

```json
{
  "article_id": 100
}
```

**响应**

```json
{
  "article_id": 100,
  "sentiment": {
    "polarity": "positive",
    "score": 0.75,
    "magnitude": 0.82
  },
  "emotions": [
    { "type": "joy", "score": 0.65 },
    { "type": "surprise", "score": 0.45 },
    { "type": "trust", "score": 0.58 }
  ],
  "model": "gemini-pro",
  "generated_at": "2025-12-10T12:30:00Z"
}
```

---

## 10.6 AI 关键词提取

**POST** `/ai/keywords`

**说明**：从文章中提取关键词和实体

**请求体**

```json
{
  "article_id": 100,
  "max_keywords": 10
}
```

**响应**

```json
{
  "article_id": 100,
  "keywords": [
    { "keyword": "人工智能", "relevance": 0.95 },
    { "keyword": "机器学习", "relevance": 0.88 },
    { "keyword": "深度学习", "relevance": 0.82 }
  ],
  "entities": [
    { "name": "Google", "type": "ORGANIZATION", "salience": 0.76 },
    { "name": "美国", "type": "LOCATION", "salience": 0.45 }
  ],
  "model": "gemini-pro",
  "generated_at": "2025-12-10T12:30:00Z"
}
```

---

## 10.7 Google Gemini API 配置（管理员）

**GET** `/admin/ai/config`

**说明**：获取 AI 配置信息

**响应**

```json
{
  "provider": "google",
  "model": "gemini-pro",
  "api_endpoint": "https://generativelanguage.googleapis.com/v1beta",
  "api_key_status": "active",
  "rate_limit": {
    "requests_per_minute": 60,
    "tokens_per_day": 1000000
  },
  "features_enabled": {
    "summarize": true,
    "classify": true,
    "chat": true,
    "recommend": true,
    "sentiment": true,
    "keywords": true
  }
}
```

---

**PATCH** `/admin/ai/config`

**说明**：更新 AI 配置

**请求体**

```json
{
  "model": "gemini-1.5-pro",
  "api_key": "AIzaSy...",
  "features_enabled": {
    "summarize": true,
    "classify": true,
    "chat": true
  }
}
```

---

## 10.8 AI 使用统计

**GET** `/admin/ai/stats`

**说明**：查看 AI 功能使用统计

**请求参数**

* `start_date`: 开始日期
* `end_date`: 结束日期
* `group_by`: day|week|month

**响应**

```json
{
  "period": {
    "start": "2025-12-01T00:00:00Z",
    "end": "2025-12-10T23:59:59Z"
  },
  "usage": [
    {
      "date": "2025-12-10",
      "requests": {
        "summarize": 150,
        "classify": 80,
        "chat": 320,
        "recommend": 200,
        "sentiment": 45,
        "keywords": 60
      },
      "tokens_used": 125000,
      "cost_usd": 0.25
    }
  ],
  "total_requests": 855,
  "total_tokens": 125000,
  "total_cost_usd": 0.25
}
```

---

如需生成同款 **OpenAPI 3.0 / Swagger 文档** 或自动生成 **后端路由模板（Node / Go / Python / Java）**，可继续给我指令。

```
```

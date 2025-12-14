# 新闻网站 PageSpec

## 1. 首页 / 新闻推荐（/）
- 组件：NavBar、SearchBar、ArticleList、Pagination、AIRecommendSlider、Footer
- 区块：
  - 顶部导航栏（Logo、导航、登录/用户）
  - 搜索与筛选区（关键词、主题、来源）
  - 新闻推荐列表（ArticleCard，分页）
  - AI 推荐区（横滑推荐）
  - 页脚
- 交互：
  - 搜索/筛选实时刷新列表
  - 推荐区点击跳转详情

## 2. 登录页（/login）
- 组件：NavBar、AuthForm、Notification
- 区块：
  - 顶部导航栏
  - 登录表单（邮箱/用户名、密码、登录按钮、注册跳转）
- 交互：
  - 表单校验、错误提示
  - 登录成功跳转首页

## 3. 注册页（/register）
- 组件：NavBar、AuthForm、Notification
- 区块：
  - 顶部导航栏
  - 注册表单（用户名、邮箱、密码、注册按钮、登录跳转）
- 交互：
  - 表单校验、错误提示
  - 注册成功自动登录/跳转

## 4. 文章列表页（/articles）
- 组件：NavBar、SearchBar、ArticleList、Pagination、Footer
- 区块：
  - 顶部导航栏
  - 搜索与筛选区
  - 文章列表（ArticleCard，分页）
  - 页脚
- 交互：
  - 筛选/搜索刷新列表
  - 点击卡片跳转详情

## 5. 文章详情页（/articles/:id）
- 组件：NavBar、ArticleDetail、TopicTag、AISummaryCard、AIChatBox、AIRecommendSlider、Footer
- 区块：
  - 顶部导航栏
  - 文章主内容（标题、作者、正文、媒体、标签、收藏/分享）
  - 右侧/底部：AI 摘要、AI 问答、相关推荐
  - 页脚
- 交互：
  - 收藏、分享、标签筛选
  - AI 摘要/问答 loading、失败重试

## 6. 主题列表页（/topics）
- 组件：NavBar、SearchBar、TopicTag、List、Pagination、Footer
- 区块：
  - 顶部导航栏
  - 主题筛选/搜索区
  - 主题列表（TopicTag，分页）
  - 页脚
- 交互：
  - 筛选/搜索刷新主题
  - 点击主题跳转详情

## 7. 主题详情页（/topics/:id）
- 组件：NavBar、TopicTag、ArticleList、Pagination、Footer
- 区块：
  - 顶部导航栏
  - 主题信息（名称、关键词、关注按钮）
  - 主题下文章列表（ArticleCard，分页）
  - 页脚
- 交互：
  - 关注/取消关注
  - 文章卡片跳转详情

## 8. 我的收藏页（/bookmarks）
- 组件：NavBar、ArticleList、Pagination、Footer
- 区块：
  - 顶部导航栏
  - 收藏文章列表（ArticleCard，分页）
  - 页脚
- 交互：
  - 取消收藏
  - 跳转详情

## 9. 阅读历史页（/history）
- 组件：NavBar、ArticleList、Pagination、Footer
- 区块：
  - 顶部导航栏
  - 历史文章列表（ArticleCard，分页）
  - 页脚
- 交互：
  - 跳转详情

## 10. 用户资料页（/profile）
- 组件：NavBar、UserProfileForm、Notification、Footer
- 区块：
  - 顶部导航栏
  - 用户信息展示与编辑（用户名、邮箱、修改密码、保存按钮）
  - 页脚
- 交互：
  - 表单校验、保存、反馈

## 11. 管理后台首页（/admin）
- 组件：NavBar、SideMenu、AdminDashboard、Footer
- 区块：
  - 顶部导航栏
  - 侧边栏菜单（用户、新闻源、文章、AI 配置等）
  - 仪表盘（统计、快捷入口）
  - 页脚

## 12. 用户管理页（/admin/users）
- 组件：NavBar、SideMenu、AdminTable、Modal、Notification
- 区块：
  - 顶部导航栏
  - 侧边栏
  - 用户表格（增删改查、分页、搜索）
- 交互：
  - 编辑、删除、重置密码弹窗

## 13. 新闻源管理页（/admin/sources）
- 组件：NavBar、SideMenu、AdminTable、Modal、Notification
- 区块：
  - 顶部导航栏
  - 侧边栏
  - 新闻源表格（增删改查、分页、搜索）
- 交互：
  - 编辑、删除弹窗

## 14. 文章管理页（/admin/articles）
- 组件：NavBar、SideMenu、AdminTable、Modal、Notification
- 区块：
  - 顶部导航栏
  - 侧边栏
  - 文章表格（增删改查、分页、搜索、隐藏/显示）
- 交互：
  - 编辑、隐藏/显示弹窗

## 15. AI 配置与统计页（/admin/ai）
- 组件：NavBar、SideMenu、AIConfigForm、AIStatsPanel、Notification
- 区块：
  - 顶部导航栏
  - 侧边栏
  - AI 配置表单（模型、API Key、功能开关）
  - AI 使用统计面板
- 交互：
  - 配置保存、统计筛选

## 16. AI 智能问答页（/ai/chat）
- 组件：NavBar、AIChatBox、AISummaryCard、Footer
- 区块：
  - 顶部导航栏
  - 问答区（多轮对话、历史）
  - AI 摘要区
  - 页脚
- 交互：
  - 发送问题、loading、失败重试

## 17. AI 摘要生成页（/ai/summarize）
- 组件：NavBar、AISummaryCard、ArticleList、Footer
- 区块：
  - 顶部导航栏
  - 摘要生成区（输入文章/选择文章、生成按钮、摘要结果）
  - 相关文章推荐
  - 页脚
- 交互：
  - 生成摘要、loading、失败重试

## 18. AI 推荐页（/ai/recommend）
- 组件：NavBar、AIRecommendSlider、ArticleList、Footer
- 区块：
  - 顶部导航栏
  - AI 推荐区（横滑）
  - 推荐文章列表
  - 页脚
- 交互：
  - 点击推荐卡片跳转详情

---
如需某页面详细原型或流程图，可继续补充需求。

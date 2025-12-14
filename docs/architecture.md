# 新闻网站前端架构设计

## 1. 整体结构

- 技术栈建议：React + TypeScript + Next.js +shadcn/ui
- 目录结构建议：
  - `/src/pages` 页面路由入口
  - `/src/components` 复用组件
  - `/src/store` 状态管理
  - `/src/services` API 请求
  - `/src/hooks` 自定义 hooks
  - `/src/utils` 工具函数
  - `/src/assets` 静态资源

## 2. 路由设计

采用前端路由（如 React Router），主要页面如下：

| 路由路径           | 页面功能           |
|-------------------|-------------------|
| `/`               | 首页/新闻推荐      |
| `/login`          | 登录              |
| `/register`       | 注册              |
| `/articles`       | 文章列表          |
| `/articles/:id`   | 文章详情          |
| `/topics`         | 主题列表          |
| `/topics/:id`     | 主题详情          |
| `/bookmarks`      | 我的收藏          |
| `/history`        | 阅读历史          |
| `/admin`          | 管理后台（权限）   |
| `/admin/users`    | 用户管理          |
| `/admin/sources`  | 新闻源管理        |
| `/admin/articles` | 文章管理          |
| `/admin/ai`       | AI 配置与统计      |
| `/ai/chat`        | AI 智能问答        |
| `/ai/summarize`   | AI 摘要生成        |
| `/ai/recommend`   | AI 推荐            |

## 3. 状态管理原则

- 推荐使用 Redux Toolkit 或 Zustand 进行全局状态管理。
- 主要状态模块：
  - 用户认证信息（token、用户信息）
  - 文章列表与详情
  - 主题列表与详情
  - 收藏与历史
  - AI 相关数据（摘要、问答、推荐等）
  - 管理后台相关状态
- 状态分层：
  - 全局状态（如用户、主题、AI 配置）
  - 局部状态（如表单输入、弹窗显示）
- 状态持久化：
  - 认证信息、用户偏好可存储于 localStorage/sessionStorage
  - 其余状态保持内存，页面刷新后重新拉取
- API 请求统一管理，建议使用 axios 并结合中间件处理 token 注入、错误处理。

## 4. 其他建议

- 路由权限控制：部分页面需登录或管理员权限
- 响应式设计，适配移动端
- 组件拆分，复用性高
- 代码分包，按需加载
- 错误与加载状态统一处理
- 国际化支持（如多语言切换）

## 5. 页面设计
- 新闻推荐页面
- 详细新闻页面
- 用户资料管理页面
- 后台管理页面

---
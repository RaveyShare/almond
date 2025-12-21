# 首页接口文档（Web 前端对接）

## 顶部一句话
- 方法：`GET /front/home/summary`
- 响应：
```json
{
  "code": 0,
  "data": {
    "summaryText": "你最近放下了很多想法，我帮你慢慢整理着",
    "signals": {
      "createdCount7d": 12,
      "activeGoals": 2,
      "recentReviews": 3,
      "busyHint": true
    }
  }
}
```

## 轻输入创建杏仁
- 方法：`POST /front/almonds`
- 请求：
```json
{ "title": "想到的内容", "content": "可选", "tags": ["随记"] }
```
- 响应：
```json
{ "code": 0, "data": { "id": "alm_123", "status": "new", "type": "unknown", "createdAt": "2025-01-01T10:00:00Z" } }
```

## 动态区（最多 5 条）
- 方法：`GET /front/home/dynamic?limit=5`
- 响应：
```json
{
  "code": 0,
  "data": {
    "items": [
      { "id": "alm_201", "title": "项目X的想法草稿", "type": "unknown", "cardType": "growing", "reason": "近期多次修改，尚未定型", "updatedAt": "2025-01-02T12:00:00Z" },
      { "id": "alm_301", "title": "线性代数公式", "type": "memory", "cardType": "review", "nextReviewAt": "2025-01-03T09:00:00Z", "reason": "到达轻提示复习窗口" },
      { "id": "alm_401", "title": "周报撰写", "type": "action", "cardType": "near-done", "progress": 0.8, "dueAt": "2025-01-04T18:00:00Z", "reason": "进度接近完成" },
      { "id": "alm_501", "title": "英语词汇量提升", "type": "goal", "cardType": "goal-progress", "progress": 0.3, "reason": "子杏仁近期有推进" }
    ]
  }
}
```

## AI 轻提示
- 方法：`GET /front/home/hints`
- 响应：
```json
{ "code": 0, "data": { "hints": [
  { "id": "hint_01", "text": "我发现有几颗杏仁其实可以合并", "relatedIds": ["alm_201", "alm_202"], "severity": "low" },
  { "id": "hint_02", "text": "要不要把这个想法拆成更小的杏仁？", "relatedIds": ["alm_501"], "severity": "low" }
] } }
```
- 忽略提示：`POST /front/home/hints/{hintId}/dismiss`
- 响应：
```json
{ "code": 0, "data": { "dismissed": true } }
```

## 最近的杏仁
- 方法：`GET /front/home/recent?limit=5`
- 响应：
```json
{ "code": 0, "data": { "items": [
  { "id": "alm_201", "title": "项目X的想法草稿", "excerpt": "……", "lastTouchedAt": "2025-01-02T12:00:00Z" },
  { "id": "alm_401", "title": "周报撰写", "excerpt": "……", "lastTouchedAt": "2025-01-02T08:00:00Z" }
] } }
```

## 杏仁列表（合并原记忆库/计划）
- 方法：`GET /front/almonds?type=&status=&query=&parentId=&limit=&cursor=`
- 响应：
```json
{ "code": 0, "data": { "list": [
  { "id": "alm_201", "title": "项目X的想法草稿", "type": "unknown", "status": "evolving", "progress": 0.2 },
  { "id": "alm_301", "title": "线性代数公式", "type": "memory", "status": "reviewing", "nextReviewAt": "2025-01-03T09:00:00Z" }
], "nextCursor": null } }
```

## 杏仁详情（目标型层级关系）
- 方法：`GET /front/almonds/{id}`
- 响应：
```json
{ "code": 0, "data": {
  "id": "alm_501", "title": "英语词汇量提升", "type": "goal", "status": "evolving", "progress": 0.3,
  "children": [{ "id": "alm_502", "title": "每天背20词", "type": "action", "status": "in-progress", "progress": 0.6 }],
  "metrics": { "lastTouchedAt": "2025-01-02T07:00:00Z", "frecency": 0.78 }
} }
```

## 行为与复盘
- 完成：`POST /front/almonds/{id}/complete`
- 响应：`{ "code": 0, "data": { "done": true, "completedAt": "2025-01-04T18:10:00Z" } }`
- 复盘：`POST /front/almonds/{id}/review`
- 响应：`{ "code": 0, "data": { "reviewed": true, "notes": "本次完成因提前规划……", "nextActionId": "alm_601" } }`
- 进度更新：`POST /front/almonds/{id}/progress`
- 请求：`{ "progress": 0.85 }`
- 响应：`{ "code": 0, "data": { "progress": 0.85 } }`

## 错误码
- 统一响应：`{ "code": 0, "message": "ok", "data": { ... } }`
- 常见错误：`401` 未认证、`403` 无权限、`400` 参数错误、`404` 不存在、`429` 频率限制。

## Mock 对应
- 开发环境可用 Mock 路由：
  - `GET /api/home/summary`
  - `GET /api/home/dynamic`
  - `GET /api/home/hints`
  - `POST /api/home/hints/{hintId}/dismiss`
  - `GET /api/home/recent`
  - `POST /api/almonds`


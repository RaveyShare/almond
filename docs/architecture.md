# 小杏仁 Monorepo 架构

## 总览
- 根仓库：`almond`（Monorepo）
- 目录结构：
  - `apps/`：终端应用（前端、移动端等）
  - `services/`：后端与中心服务（用户中心、AI 中心、订单中心等）
  - `docs/`：架构与设计文档

## 子仓库与子模块
- 独立仓库（HTTPS）：
  - `https://github.com/RaveyShare/almond-front.git`（Next.js 前端）
  - `https://github.com/RaveyShare/almond-back.git`（后端）
  - `https://github.com/RaveyShare/user-center.git`（用户中心）
  - `https://github.com/RaveyShare/ai-center.git`（AI 中心）
  - `https://github.com/RaveyShare/order-center.git`（订单与计费）
- 在主仓库中以 `git submodule` 引入：
  - `apps/almond-front` → `https://github.com/RaveyShare/almond-front.git`
  - `services/user-center` → `https://github.com/RaveyShare/user-center.git`
  - `services/ai-center` → `https://github.com/RaveyShare/ai-center.git`
  - `services/almond-back` → `https://github.com/RaveyShare/almond-back.git`
  - `services/order-center` → `https://github.com/RaveyShare/order-center.git`

## 依赖关系（简化）
- `almond-front`：
  - 通过同源代理调用 `user-center` 的认证与二维码接口
  - 通过后端 `almond-back` 的内存项与复盘接口
  - 通过 `ai-center` 的推理生成接口（图像/音频/复盘建议）
- `almond-back`：
  - 持久化数据与业务聚合
  - 转发到 `ai-center` 与 `user-center`

## 环境变量约定
- 统一域名：`https://almond.ravey.site`
- 前端：
  - `NEXT_PUBLIC_API_URL=https://almond.ravey.site/api`
  - `NEXT_PUBLIC_USER_CENTER_URL=https://almond.ravey.site`
  - `NEXT_PUBLIC_ALMOND_BACK_URL=https://almond.ravey.site`

## 开发与提交
- 子项目开发：在子项目目录正常开发、提交与推送
- 主仓库文档：在 `docs/` 更新架构与部署文档

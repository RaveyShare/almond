# 部署指南

## 前置
- 独立创建子服务仓库（GitHub）
- 在主仓库添加子模块（见 `docs/services.md`）
- 域名与环境统一：`https://almond.ravey.site`

## 环境变量（前端）
- `NEXT_PUBLIC_API_URL=https://almond.ravey.site/api`
- `NEXT_PUBLIC_USER_CENTER_URL=https://almond.ravey.site`
- `NEXT_PUBLIC_ALMOND_BACK_URL=https://almond.ravey.site`

## 构建与发布（前端）
```bash
# 安装依赖并构建
cd apps/almond-front
npm ci
npm run build

# 运行开发
npm run dev
```

## 子模块更新
```bash
# 拉取子模块最新代码
git submodule update --init --recursive
git submodule foreach git pull origin main
```

## 运维建议
- 将各服务独立部署，网关统一到 `almond.ravey.site`
- 使用反向代理实现同源接口路由
- 统一监控与日志，规范化错误码与响应结构（如 `code=0|200`）

## 访问方式说明
- 推荐使用 HTTPS 形式的仓库地址（如 `https://github.com/RaveyShare/almond-front.git`）
- 如使用私有仓库，CI 环境可配置 GitHub Token 以拉取子模块

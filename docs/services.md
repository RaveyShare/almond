# 服务清单与职责

## apps
- `apps/almond-front`：Web 前端（Next.js）
  - 对话、记忆库、计划与复盘页面
  - 通过代理访问用户中心与后端接口

## services
- `services/user-center`：认证与用户资料
  - 登录、注册、二维码与小程序码
  - 统一用户与令牌管理
- `services/ai-center`：推理与生成
  - 图像生成、音频生成、复盘建议
  - 模型与提示词管理
- `services/almond-back`：业务后端
  - 记忆项、计划与复盘数据
  - 对外 API 聚合与转发
- `services/order-center`：订单与计费
  - 套餐、Credits 管理、对账

## 子模块引入示例（HTTPS）
```bash
# 前端（apps）
cd almond/apps
git submodule add https://github.com/RaveyShare/almond-front.git

# 用户中心（services）
cd ../services
git submodule add https://github.com/RaveyShare/user-center.git

# 其他服务（可选）
git submodule add https://github.com/RaveyShare/ai-center.git
git submodule add https://github.com/RaveyShare/almond-back.git
git submodule add https://github.com/RaveyShare/order-center.git
```

## 约定
- 统一域名：`https://almond.ravey.site`
- 前端通过同源代理路由调用用户中心与后端
- 微信授权回调由服务端处理，前端仅负责展示与跳转

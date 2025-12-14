# 底层基础模块说明（common-dependencies / common-starter）

## 模块定位
- `common-dependencies`：统一版本治理的 BOM（Bill of Materials），只做依赖版本管理，不产出代码与二进制。
- `common-starter`：基础能力聚合（`common-api/common-core/common-web/common-utils/common-dao/common-service/common-redis`），在业务服务中作为“底座”被依赖复用。

## 为什么保留在同仓库（Monorepo）
- **完整开源**：底层能力与业务服务保持一致的源码版本与变更历史，避免“只看到业务但缺底座”的不完整体验。
- **一致构建**：顶层聚合构建一次即可验证所有模块与版本治理（含 BOM）。
- **协作简单**：跨模块重构和联调不需要跨仓库同步。

## 避免“看着迷糊”的组织方式
- 目录分层建议：
  - `/foundation/`（可选重命名）：放置 `common-dependencies`、`common-starter` 及其子模块
  - `/services/`：业务服务，如 `user-center`、`almond-back`
  - `/apps/`：应用入口或运行态（前端/小程序等）
- 文档与 README：
  - 在 `docs/` 增设本说明文件，清楚描述底层与业务的边界与依赖关系
  - 在 `common-starter` 与各子模块内添加简明 `README.md`，说明用途与对外 API

## 外部工程的复用方式
- **推荐**：使用发布的稳定版 BOM 与基础模块
  - 业务工程引入：`com.ravey.common:common-dependencies:1.0.7`（import scope）
  - 然后按需依赖 `common-starter` 下的具体模块（例如 `common-web`、`common-dao-mp` 等）
- **源码复用（可选）**：
  - 通过 Git Submodule 引入 `foundation` 目录，适合需要二次开发的场景

## 版本与发布建议
- BOM 使用正式版（如 `1.0.7`），避免 SNAPSHOT 在业务工程造成解析不稳定
- 为 `common-starter` 子模块打稳定版号，按需发布到制品库（GitHub Packages 或私有仓库）
- 业务工程默认依赖发布版；如需本地改动，可 `mvn install` 到本地私库再聚合编译

## 在本仓库的当前实践
- 已将 BOM 统一到 `1.0.7` 并本地安装，`user-center`/`mindally-back` 可直接依赖
- 保留 `common-starter` 全量源码，保证开箱即可构建与调试

## 迁移到 `/foundation` 的计划（如你同意）
1. 将 `services/common-dependencies` 与 `services/common-starter` 平移到 `/foundation/` 目录
2. 更新顶层聚合与文档路径
3. 保持构建与使用方式不变（业务工程依然通过 BOM 与 `common-starter` 依赖）

该调整仅改变目录结构与文档组织，构建与发布流程不受影响。*** End Patch***  }}/>

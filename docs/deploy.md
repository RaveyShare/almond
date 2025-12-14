# 部署说明（开发环境）

## 依赖与准备
- 安装 Docker 与 Docker Compose
- 代码目录下将自动创建本地数据与配置目录：
  - `./mysql_data`、`./redis_data`
  - `./nacos_data`、`./nacos_logs`
  - Nacos 配置位于 `./nacos/conf/`

## 组件与端口
- MySQL: `3306`，默认库 `nacos`，用户/密码 `root/root`
- Redis: `6379`
- Nacos: `8848`（HTTP API/控制台）、`9848/9849`（gRPC）
- Nacos 控制台默认账户：`nacos/nacos`

## 启动
- 后台启动：`docker compose up -d`
- 查看状态：`docker compose ps`
- 首次启动会自动执行 `ops/sql/nacos-mysql-init.sql` 初始化 Nacos 所需表与默认账号

## 配置位置
- Nacos 使用本地挂载的配置文件：
  - `nacos/conf/application.properties`（已内置 MySQL 连接配置）
  - `nacos/conf/nacos-logback.xml`（日志滚动配置）
- 如需修改数据库连接，编辑：
  - `db.url.0`、`db.user`、`db.password`

## 常见问题
- 端口被占用：
  - 检查监听：`lsof -nP -iTCP -sTCP:LISTEN | grep 3306`
- MySQL 初始化 SQL 未执行：
  - 仅在数据目录为空时执行。已存在数据目录请先清理：`docker compose down -v` 后再 `up -d`
- 修改配置后生效：
  - 重新启动 Nacos 容器：`docker compose restart nacos`

## 停止与清理
- 停止但保留数据：`docker compose down`
- 连数据一起清理：`docker compose down -v`

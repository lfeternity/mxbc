# 蜜雪冰城点单系统（MXBC）

基于「苍穹外卖」二次开发的外卖点单系统，包含：

- 管理端（Web）
- 用户端（小程序/uni-app）
- 后端服务（Spring Boot）
- AI 客服能力（需自行配置第三方 API）

> 说明：当前仓库中的示例数据已做脱敏处理；支付流程为演示版本（非完整商用支付流程）。

![preview](./assets/00.png)

## 项目特点

- 管理端支持菜品、套餐、订单、员工等基础管理
- 用户端支持下单、历史订单、地址管理等流程
- 后端支持 JWT 鉴权、定时任务、WebSocket 推送
- 接入 AI 客服（基于科大讯飞接口，自行申请配置）

## 技术栈

- 后端：`Spring Boot` `MyBatis` `MySQL` `Redis` `Maven` `WebSocket` `Spring Cache` `Spring Task`
- 前端管理端：`Vue2` `TypeScript` `Element UI` `Vue CLI`
- 小程序端：`uni-app` / 微信小程序

## 目录结构

```text
.
├─mxbc/                  # 后端工程（Maven 多模块）
│  ├─sky-server/         # 启动模块
│  ├─sky-common/
│  └─sky-pojo/
├─mxbc-frontend/         # 管理端前端（Vue2 + TS）
├─uniapp-hbuilder/       # uni-app 项目
├─mp-weixin/             # 微信小程序构建产物/工程
├─assets/                # 文档图片
└─sky_take_out.sql       # 数据库初始化脚本
```

## 环境要求

- JDK：`1.8+`（推荐 8 或 11）
- Maven：`3.8+`
- MySQL：`8.0+`
- Redis：`6+`
- Node.js：推荐 `16.x`（Vue2 + TS3 老项目，Node 过高版本可能出现类型兼容问题）
- Yarn：`1.x`（可选，推荐与本项目历史环境一致）

## 快速启动

### 1. 初始化数据库

执行根目录 SQL 脚本：

```sql
source sky_take_out.sql;
```

### 2. 启动后端

1. 打开目录 `mxbc`
2. 修改配置文件：
   `mxbc/sky-server/src/main/resources/application-dev.yml`
3. 填写以下配置项：
   - MySQL：`sky.datasource.*`
   - Redis：`sky.redis.*`
   - OSS：`sky.alioss.*`（可选）
   - 微信：`sky.wechat.*`（如需相关能力）
   - AI：`sky.ai.*`（科大讯飞接口，自行申请）

启动方式（二选一）：

```bash
# 方式1：IDEA 直接运行 SkyApplication
# 方式2：命令行
cd mxbc
mvn -pl sky-server -am spring-boot:run
```

默认端口：`8080`

### 3. 启动管理端前端

1. 打开目录 `mxbc-frontend`
2. 安装依赖
3. 配置 `.env.development`
4. 启动开发服务

```bash
cd mxbc-frontend
yarn install
yarn serve
```

`.env.development` 关键配置示例：

```env
VUE_APP_BASE_API='/api'
NODE_ENV='development'
VUE_APP_NODE_ENV='dev'
VUE_APP_URL='http://localhost:8080/admin'
VUE_APP_SOCKET_URL='ws://localhost:8080/ws/'
VUE_CLI_BABEL_TRANSPILE_MODULES=true
VUE_APP_DELETE_PERMISSIONS=true
```

### 4. 微信小程序（mp-weixin）

1. 下载微信开发者工具
2. 获取自己的小程序 `AppID`
3. 导入 `mp-weixin` 目录
4. 按需修改后端接口地址
5. 真机调试需在小程序后台配置合法域名

### 5. uni-app（uniapp-hbuilder）

1. 使用 HBuilder X 打开 `uniapp-hbuilder`
2. 在 `manifest.json` 配置小程序 `AppID`
3. 配置微信开发者工具路径
4. 运行到微信小程序

## 常见问题

### 1. 前端安装/构建时报大量 TypeScript 类型错误

建议使用 `Node 16.x + Yarn 1.x`，并清理后重装依赖：

```bash
cd mxbc-frontend
rm -rf node_modules
yarn install
```

Windows PowerShell 可用：

```powershell
Remove-Item -Recurse -Force node_modules
yarn install
```

### 2. 后端启动报数据库连接失败

优先检查 `application-dev.yml` 中：

- `sky.datasource.host`
- `sky.datasource.port`
- `sky.datasource.database`
- `sky.datasource.username`
- `sky.datasource.password`

### 3. AI 客服不可用

请确认 `sky.ai.hostUrl/domain/appid/apiSecret/apiKey` 均已填写，并且网络可访问对应服务。

## 安全与开源说明

- 仓库中的示例数据为演示用途，已进行脱敏
- 请勿在开源仓库提交真实手机号、身份证号、密钥、回调公网地址
- 生产环境请更换 JWT 密钥、默认密码与所有第三方凭据

## License

本项目使用仓库根目录中的 [LICENSE](./LICENSE)。

## 仿蜜雪冰城系统

参考苍穹外卖，跳过微信支付(无商家微信)，增加了AI客服功能

技术栈: `SpringBoot` `MyBatis` `Redis` `MySQL` `Nginx` `SpringCache` `SpringTask` `WebSocket` `Vue` `Maven` `Uni-app`

![avator](./assets/00.png)


### 后端部署

1.运行`sky_take_out.sql`脚本

2.在idea打开`mxbc`文件夹

3.在`sky-server/src/main/resources/application-dev.yml`中修改数据库等配置信息
科大讯飞的api需要自己申请


### 前端部署

1.在idea打开`mxbc-frontend`文件夹

2.安装yarn(如果没有)

```shell
npm install yarn -g
```

3.切换淘宝镜像源

```shell
yarn config set registry https://registry.npmmirror.com
```

4.禁用SSL证书验证

```shell
yarn config set strict-ssl false
```

5.增加yarn超时时间

```shell
yarn config set network-timeout 600000
```

6.安装依赖

```shell
yarn install
```

7.修改配置

.env.development开发环境

```js
# Base api
VUE_APP_BASE_API = '/api'

# vue-cli uses the VUE_CLI_BABEL_TRANSPILE_MODULES environment variable,
# to control whether the babel-plugin-dynamic-import-node plugin is enabled.
# It only does one thing by converting all import() to require().
# This configuration can significantly increase the speed of hot updates,
# when you have a large number of pages.
# Detail:  https://github.com/vuejs/vue-cli/blob/dev/packages/@vue/babel-preset-app/index.js

NODE_ENV = 'development'
VUE_APP_NODE_ENV = 'dev'

//后端服务的地址
VUE_APP_URL = 'http://localhost:8080/admin'

VUE_APP_SOCKET_URL = 'ws://localhost:8080/ws/'

VUE_CLI_BABEL_TRANSPILE_MODULES = true
# 删除权限 true/有
VUE_APP_DELETE_PERMISSIONS = true

```

8.运行

```shell
yarn serve
```

### 微信小程序快速启动

1.下载微信开发者工具

2.获取个人小程序Appid

3.将mp-weixin导入微信开发者工具，填写自己的Appid

4.设置->安全->开放端口

5.在common/vendor.js中配置baseUrl

6.若想真机调试，在微信小程序平台配置合法域名

### 小程序项目部署

1.在HBuilder X导入uniapp-hbuilder

2.在manifest.json配置微信小程序Appid

3.在工具->设置->运行配置->微信开发者工具路径中，选择具体的安装路径

4.运行到微信小程序

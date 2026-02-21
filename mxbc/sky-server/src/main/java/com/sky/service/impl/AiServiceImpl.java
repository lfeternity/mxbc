package com.sky.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.sky.service.AiService;
import lombok.extern.slf4j.Slf4j;
import okhttp3.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.IOException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicBoolean;

@Slf4j
@Service
public class AiServiceImpl implements AiService {
    // 对话历史存储集合
    private final List<RoleContent> historyList = new ArrayList<>();
    // 大模型的答案汇总
    private StringBuilder totalAnswer = new StringBuilder();

    // Gson实例，用于JSON解析
    private static final Gson gson = new Gson();

    // 配置参数
    @Value("${ai.hostUrl}")
    private String hostUrl = "";
    @Value("${ai.domain}")
    private String domain = "";
    @Value("${ai.appid}")
    private String appid = "";
    @Value("${ai.apiSecret}")
    private String apiSecret = "";
    @Value("${ai.apiKey}")
    private String apiKey = "";

    /**
     * 获取鉴权URL
     * @param question
     * @return
     */
    @Override
    public String getAnswer(String question) {
        if (question == null || question.trim().isEmpty()) {
            return "请输入有效问题";
        }


        try {
            // 构建鉴权URL
            String authUrl = getAuthUrl(hostUrl, apiKey, apiSecret);
            OkHttpClient client = new OkHttpClient.Builder().build();
            String url = authUrl.toString().replace("http://", "ws://").replace("https://", "wss://");
            Request request = new Request.Builder().url(url).build();

            // 使用CountDownLatch等待响应
            CountDownLatch latch = new CountDownLatch(1);
            WebSocket webSocket = client.newWebSocket(request, new AiWebSocketListener(latch, question));

            // 等待响应完成或超时
            boolean completed = latch.await(30, TimeUnit.SECONDS);
            if (!completed) {
                webSocket.close(1000, "请求超时");
                return "请求超时，请重试";
            }

            String answer = totalAnswer.toString();
            log.info("AI回答：" + totalAnswer);
            return answer != null ? answer : "暂无回答内容";

        } catch (Exception e) {
            e.printStackTrace();
            return "处理请求时出错: " + e.getMessage();
        }
    }



    // WebSocket监听器，处理连接和消息
    class AiWebSocketListener extends WebSocketListener {
        private final CountDownLatch latch;
        private final String question;
        private final AtomicBoolean isResponseComplete = new AtomicBoolean(false);

        public AiWebSocketListener(CountDownLatch latch, String question) {
            this.latch = latch;
            this.question = question;
        }

        /**
         * 当WebSocket连接打开时调用
         * @param webSocket
         * @param response
         */
        @Override
        public void onOpen(WebSocket webSocket, Response response) {
            totalAnswer.setLength(0);
            super.onOpen(webSocket, response);
            // 发送请求参数
            sendRequest(webSocket, question);
        }

        /**
         * 当WebSocket接收到消息时调用
         * @param webSocket
         * @param text
         */
        @Override
        public void onMessage(WebSocket webSocket, String text) {
            try {
                // 解析响应
                JsonParse myJsonParse = gson.fromJson(text, JsonParse.class);
                if (myJsonParse.header.code != 0) {
                    System.err.println("发生错误，错误码为：" + myJsonParse.header.code);
                    System.err.println("本次请求的sid为：" + myJsonParse.header.sid);
                    webSocket.close(1000, "Error code: " + myJsonParse.header.code);
                    latch.countDown();
                    return;
                }

                // 处理回答内容
                List<Text> textList = myJsonParse.payload.choices.text;
                for (Text temp : textList) {
                    if (temp != null && temp.content != null) {
                        totalAnswer.append(temp.content);
                    }
                }
//                // 处理回答内容
//                List<Text> textList = myJsonParse.payload.choices.text;
//                for (Text temp : textList) {
//                    totalAnswer.append(temp.content);
//                }



                // 判断是否为完整响应（根据API规范调整）
                if (myJsonParse.header.status == 2) {
                    // 添加到历史记录
                    addToHistory(question, totalAnswer.toString());
                    // 标记响应完成
                    isResponseComplete.set(true);
                    latch.countDown();
                }

            } catch (Exception e) {
                e.printStackTrace();
                latch.countDown();
            }
        }

        /**
         * 当WebSocket连接失败时调用
         * @param webSocket
         * @param t
         * @param response
         */
        @Override
        public void onFailure(WebSocket webSocket, Throwable t, Response response) {
            super.onFailure(webSocket, t, response);
            try {
                System.err.println("WebSocket连接失败");
                if (response != null) {
                    System.err.println("错误码: " + response.code());
                    if (response.body() != null) {
                        System.err.println("错误信息: " + response.body().string());
                    }
                }
                t.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                latch.countDown();
            }
        }

        /**
         * 当WebSocket连接关闭时调用
         * @param webSocket
         * @param code
         * @param reason
         */
        @Override
        public void onClosed(WebSocket webSocket, int code, String reason) {
            super.onClosed(webSocket, code, reason);
            System.out.println("WebSocket连接已关闭，代码: " + code + ", 原因: " + reason);
            if (!isResponseComplete.get()) {
                latch.countDown();
            }
        }

        // 发送请求参数
        private void sendRequest(WebSocket webSocket, String question) {
            try {
                JSONObject requestJson = new JSONObject();

                // 构造请求头
                JSONObject header = new JSONObject();
                header.put("app_id", appid);
                header.put("uid", UUID.randomUUID().toString().substring(0, 10));

                // 构造请求参数
                JSONObject parameter = new JSONObject();
                JSONObject chat = new JSONObject();
                chat.put("domain", domain);
                chat.put("temperature", 0.5);
                chat.put("max_tokens", 4096);
                parameter.put("chat", chat);

                // 构造payload
                JSONObject payload = new JSONObject();
                JSONObject message = new JSONObject();
                JSONArray text = new JSONArray();

                // 添加系统提示
                RoleContent roleSystem = new RoleContent();
                roleSystem.setRole("system");
                roleSystem.setContent("你是一个智能客服，接下来你要用客服的语气和我对话");
                text.add(JSON.toJSON(roleSystem));

                // 添加历史记录
                for (RoleContent history : historyList) {
                    text.add(JSON.toJSON(history));
                }

                // 添加当前问题
                RoleContent userQuestion = new RoleContent();
                userQuestion.setRole("user");
                userQuestion.setContent(question);
                text.add(JSON.toJSON(userQuestion));

                message.put("text", text);
                payload.put("message", message);

                requestJson.put("header", header);
                requestJson.put("parameter", parameter);
                requestJson.put("payload", payload);

                webSocket.send(requestJson.toString());

            } catch (Exception e) {
                e.printStackTrace();
                latch.countDown();
            }
        }
    }

    // 添加到对话历史
    private void addToHistory(String question, String answer) {
        // 限制历史记录长度（示例：最多保留10条）
        if (historyList.size() >= 10) {
            historyList.remove(0);
        }

        // 添加用户问题
        RoleContent userContent = new RoleContent();
        userContent.setRole("user");
        userContent.setContent(question);
        historyList.add(userContent);

        // 添加AI回答
        RoleContent aiContent = new RoleContent();
        aiContent.setRole("assistant");
        aiContent.setContent(answer);
        historyList.add(aiContent);
    }

    // 鉴权方法
    private String getAuthUrl(String hostUrl, String apiKey, String apiSecret) throws Exception {
        URL url = new URL(hostUrl);
        // 时间
        SimpleDateFormat format = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss z", Locale.US);
        format.setTimeZone(TimeZone.getTimeZone("GMT"));
        String date = format.format(new Date());
        // 拼接
        String preStr = "host: " + url.getHost() + "\n" +
                "date: " + date + "\n" +
                "GET " + url.getPath() + " HTTP/1.1";

        // HMAC-SHA256加密
        Mac mac = Mac.getInstance("HmacSHA256");
        SecretKeySpec spec = new SecretKeySpec(apiSecret.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
        mac.init(spec);
        byte[] hexDigits = mac.doFinal(preStr.getBytes(StandardCharsets.UTF_8));

        // Base64加密
        String sha = Base64.getEncoder().encodeToString(hexDigits);

        // 拼接Authorization
        String authorization = String.format("api_key=\"%s\", algorithm=\"%s\", headers=\"%s\", signature=\"%s\"",
                apiKey, "hmac-sha256", "host date request-line", sha);

        // 拼接URL
        HttpUrl httpUrl = Objects.requireNonNull(HttpUrl.parse("https://" + url.getHost() + url.getPath())).newBuilder()
                .addQueryParameter("authorization", Base64.getEncoder().encodeToString(authorization.getBytes(StandardCharsets.UTF_8)))
                .addQueryParameter("date", date)
                .addQueryParameter("host", url.getHost())
                .build();

        return httpUrl.toString();
    }

    // 返回的JSON结果拆解类
    class JsonParse {
        Header header;
        Payload payload;
    }

    class Header {
        int code;
        int status;
        String sid;
    }

    class Payload {
        Choices choices;
    }

    class Choices {
        List<Text> text;
    }

    class Text {
        String role;
        String content;
    }

    class RoleContent {
        String role;
        String content;

        public String getRole() {
            return role;
        }

        public void setRole(String role) {
            this.role = role;
        }

        public String getContent() {
            return content;
        }

        public void setContent(String content) {
            this.content = content;
        }
    }
}
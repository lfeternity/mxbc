package com.sky.controller.admin;

import com.sky.result.Result;
import com.sky.service.AiService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;


@RequestMapping("/admin/ai-service")
@RestController
@RequiredArgsConstructor
public class AiController {

    private final AiService aiService;

    /**
     * 获取AI的答案
     *
     * @param payload
     * @return
     */
    @PostMapping
    public Result<String> getAnswer(@RequestBody Map<String, String> payload) {
        String question = payload.get("question");
        return Result.success(aiService.getAnswer(question));
    }


}

package com.fenglin.springboottest.controller;

import com.fenglin.springboottest.entity.Danmaku;
import com.fenglin.springboottest.service.DanmakuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * 弹幕接口（REST，返回 JSON，供 Vue 前端调用）
 *
 * 接口列表：
 *   GET  /api/danmaku?videoId=<媒体id>&ep=<集数>   获取某视频某集的弹幕列表
 *   POST /api/danmaku                              发送一条弹幕（JSON: videoId, episode, content, color, playTime）
 */
@RestController
@RequestMapping("/api/danmaku")
@CrossOrigin  // 允许跨域，Vue 前端才能访问
public class DanmakuController {

    @Autowired
    private DanmakuService danmakuService;

    /** 获取某视频某集的弹幕列表 */
    @GetMapping
    public Map<String, Object> list(
            @RequestParam String videoId,
            @RequestParam(required = false, defaultValue = "1") Integer ep) {
        Map<String, Object> result = new HashMap<>();
        result.put("code", 200);
        result.put("msg", "success");
        result.put("data", danmakuService.listByVideo(videoId, ep));
        return result;
    }

    /** 发送一条弹幕 */
    @PostMapping
    public Map<String, Object> add(@RequestBody Danmaku danmaku) {
        Map<String, Object> result = new HashMap<>();
        if (danmaku.getContent() == null || danmaku.getContent().trim().isEmpty()) {
            result.put("code", 400);
            result.put("msg", "弹幕内容不能为空");
            return result;
        }
        // 简单防护：限制文本长度，避免超长写入
        if (danmaku.getContent().length() > 200) {
            danmaku.setContent(danmaku.getContent().substring(0, 200));
        }
        result.put("code", 200);
        result.put("msg", "success");
        result.put("data", danmakuService.add(danmaku));
        return result;
    }
}

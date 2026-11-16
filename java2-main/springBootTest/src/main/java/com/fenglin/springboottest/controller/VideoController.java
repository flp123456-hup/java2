package com.fenglin.springboottest.controller;

import com.fenglin.springboottest.entity.Video;
import com.fenglin.springboottest.service.VideoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 首页短视频接口（REST，返回 JSON，供 Vue 前端调用）
 *
 * 接口列表：
 *   GET /api/videos       获取全部短视频（首页「视频」竖屏信息流用）
 *   GET /api/videos/{id}  根据 id 获取单条
 */
@RestController
@RequestMapping("/api/videos")
@CrossOrigin  // 允许跨域，Vue 前端才能访问
public class VideoController {

    @Autowired
    private VideoService videoService;

    /** 获取全部短视频列表 */
    @GetMapping
    public Map<String, Object> list() {
        Map<String, Object> result = new HashMap<>();
        result.put("code", 200);
        result.put("msg", "success");
        List<Video> data = videoService.listAll();
        result.put("data", data);
        return result;
    }

    /** 根据 id 获取单条 */
    @GetMapping("/{id}")
    public Map<String, Object> getById(@PathVariable Long id) {
        Map<String, Object> result = new HashMap<>();
        result.put("code", 200);
        result.put("msg", "success");
        result.put("data", videoService.getById(id));
        return result;
    }
}

package com.fenglin.springboottest.controller;

import com.fenglin.springboottest.entity.Variety;
import com.fenglin.springboottest.service.VarietyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 综艺接口（REST，返回 JSON，供 Vue 前端调用）
 *
 * 接口列表：
 *   GET /api/variety?sort=hot|score&order=asc|desc   获取综艺列表（按热度/评分排序，默认热度倒序）
 *   GET /api/variety/{id}                           根据 id 获取单部
 */
@RestController
@RequestMapping("/api/variety")
@CrossOrigin  // 允许跨域，Vue 前端才能访问
public class VarietyController {

    @Autowired
    private VarietyService varietyService;

    /** 获取综艺列表，支持按热度/评分排序 */
    @GetMapping
    public Map<String, Object> list(
            @RequestParam(required = false, defaultValue = "hot") String sort,
            @RequestParam(required = false, defaultValue = "desc") String order) {
        Map<String, Object> result = new HashMap<>();
        result.put("code", 200);
        result.put("msg", "success");
        result.put("data", varietyService.listSorted(sort, order));
        return result;
    }

    /** 根据 id 获取单部 */
    @GetMapping("/{id}")
    public Map<String, Object> getById(@PathVariable Long id) {
        Map<String, Object> result = new HashMap<>();
        result.put("code", 200);
        result.put("msg", "success");
        result.put("data", varietyService.getById(id));
        return result;
    }
}

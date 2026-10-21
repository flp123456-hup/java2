package com.fenglin.springboottest.controller;

import com.fenglin.springboottest.entity.User;
import com.fenglin.springboottest.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * 用户接口（REST 风格，返回 JSON，供 Vue 前端调用）
 *
 * 接口列表：
 *   POST /api/user/register  注册 { username, password }
 *   POST /api/user/login     登录  { username, password }
 */
@RestController
@RequestMapping("/api/user")
@CrossOrigin  // 允许跨域，Vue 前端才能访问
public class UserApiController {

    @Autowired
    private UserService userService;

    /** 注册 */
    @PostMapping("/register")
    public Map<String, Object> register(@RequestBody User user) {
        Map<String, Object> result = new HashMap<>();
        try {
            User saved = userService.register(user);
            result.put("code", 200);
            result.put("msg", "注册成功");
            result.put("data", saved);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", e.getMessage());
        }
        return result;
    }

    /** 登录 */
    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody User user) {
        Map<String, Object> result = new HashMap<>();
        User dbUser = userService.login(user.getUsername(), user.getPassword());
        if (dbUser != null) {
            result.put("code", 200);
            result.put("msg", "登录成功");
            result.put("data", dbUser);
        } else {
            result.put("code", 500);
            result.put("msg", "用户名或密码错误");
        }
        return result;
    }
}

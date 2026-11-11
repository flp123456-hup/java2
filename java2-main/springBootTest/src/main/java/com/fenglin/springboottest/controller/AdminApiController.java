package com.fenglin.springboottest.controller;

import com.fenglin.springboottest.entity.AdminUser;
import com.fenglin.springboottest.entity.LoginRecord;
import com.fenglin.springboottest.entity.User;
import com.fenglin.springboottest.service.AdminUserService;
import com.fenglin.springboottest.service.LoginRecordService;
import com.fenglin.springboottest.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * 后台管理接口（REST 风格，返回 JSON，供 Vue 后台管理系统调用）
 *
 * 接口列表：
 *   POST /api/admin/login                    管理员登录 { username, password }
 *   GET  /api/admin/users                    用户管理列表（含登录次数 / 最近登录时间 / 头像 / 登录记录）
 *   GET  /api/admin/users/{username}/records 某个用户的登录记录明细
 */
@RestController
@RequestMapping("/api/admin")
@CrossOrigin  // 允许跨域，Vue 前端才能访问
public class AdminApiController {

    /** 统一默认头像路径（前端 public/avatars 与后端 static/avatars 均放置同名图片） */
    private static final String DEFAULT_AVATAR = "/avatars/user-avatar.jpg";

    private static final DateTimeFormatter FMT = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @Autowired
    private AdminUserService adminUserService;

    @Autowired
    private UserService userService;

    @Autowired
    private LoginRecordService loginRecordService;

    /** 管理员登录（校验 admin_user 表） */
    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody AdminUser adminUser) {
        Map<String, Object> result = new HashMap<>();
        AdminUser db = adminUserService.login(adminUser.getUsername(), adminUser.getPassword());
        if (db != null) {
            db.setPassword(null); // 不回传密码
            result.put("code", 200);
            result.put("msg", "登录成功");
            result.put("data", db);
        } else {
            result.put("code", 500);
            result.put("msg", "管理员账号或密码错误");
        }
        return result;
    }

    /** 用户管理列表：用户 + 头像 + 注册时间 + 登录次数 + 最近登录时间 + 登录记录 */
    @GetMapping("/users")
    public Map<String, Object> users() {
        Map<String, Object> result = new HashMap<>();
        try {
            List<User> users = userService.list();
            List<LoginRecord> records = loginRecordService.list();

            // 按 username 分组所有登录记录
            Map<String, List<LoginRecord>> byName = new HashMap<>();
            for (LoginRecord r : records) {
                if (r.getUsername() != null) {
                    byName.computeIfAbsent(r.getUsername(), k -> new ArrayList<>()).add(r);
                }
            }

            List<Map<String, Object>> data = new ArrayList<>();
            for (User u : users) {
                Map<String, Object> item = new LinkedHashMap<>();
                item.put("id", u.getId());
                item.put("username", u.getUsername());
                item.put("avatar", DEFAULT_AVATAR);
                item.put("createTime", fmt(u.getCreateTime()));

                List<LoginRecord> rs = byName.getOrDefault(u.getUsername(), new ArrayList<>());
                item.put("loginCount", rs.size());
                item.put("lastLoginTime", rs.stream()
                        .map(LoginRecord::getLoginTime)
                        .filter(Objects::nonNull)
                        .max(Comparator.naturalOrder())
                        .map(this::fmt)
                        .orElse(null));
                // 登录记录明细（按时间倒序），点进用户即可看到登录数据
                item.put("records", rs.stream()
                        .map(LoginRecord::getLoginTime)
                        .filter(Objects::nonNull)
                        .sorted(Comparator.reverseOrder())
                        .map(this::fmt)
                        .collect(java.util.stream.Collectors.toList()));
                data.add(item);
            }

            // 登录次数多的排前面
            data.sort((a, b) -> Integer.compare((int) b.get("loginCount"), (int) a.get("loginCount")));

            result.put("code", 200);
            result.put("msg", "查询成功");
            result.put("data", data);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "查询失败：" + e.getMessage());
        }
        return result;
    }

    /** 某个用户的登录记录明细（点进用户查看登录数据） */
    @GetMapping("/users/{username}/records")
    public Map<String, Object> userRecords(@PathVariable String username) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<LoginRecord> rs = loginRecordService.lambdaQuery()
                    .eq(LoginRecord::getUsername, username)
                    .orderByDesc(LoginRecord::getLoginTime)
                    .list();
            List<String> times = new ArrayList<>();
            for (LoginRecord r : rs) {
                times.add(fmt(r.getLoginTime()));
            }
            Map<String, Object> data = new LinkedHashMap<>();
            data.put("username", username);
            data.put("loginCount", times.size());
            data.put("records", times);
            result.put("code", 200);
            result.put("msg", "查询成功");
            result.put("data", data);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "查询失败：" + e.getMessage());
        }
        return result;
    }

    /** LocalDateTime → "yyyy-MM-dd HH:mm:ss" 字符串，避免前端拿到数组格式 */
    private String fmt(LocalDateTime t) {
        return t == null ? null : FMT.format(t);
    }
}

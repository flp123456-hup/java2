package com.fenglin.springboottest.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.fenglin.springboottest.entity.User;
import com.fenglin.springboottest.mapper.UserMapper;
import com.fenglin.springboottest.service.UserService;
import org.springframework.stereotype.Service;

/**
 * 用户 Service 实现类
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Override
    public User register(User user) {
        // 1. 校验用户名是否已存在
        Long count = lambdaQuery().eq(User::getUsername, user.getUsername()).count();
        if (count > 0) {
            throw new RuntimeException("用户名已被注册");
        }
        // 2. 密码长度校验：1-18 位
        String pwd = user.getPassword();
        if (pwd == null || pwd.isEmpty() || pwd.length() > 18) {
            throw new RuntimeException("密码长度须为 1-18 位");
        }
        // 3. 保存到数据库
        save(user);
        return user;
    }

    @Override
    public User login(String username, String password) {
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        wrapper.eq("username", username).eq("password", password);
        return getOne(wrapper);
    }
}

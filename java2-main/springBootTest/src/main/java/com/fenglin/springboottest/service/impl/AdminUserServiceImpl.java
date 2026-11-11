package com.fenglin.springboottest.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.fenglin.springboottest.entity.AdminUser;
import com.fenglin.springboottest.mapper.AdminUserMapper;
import com.fenglin.springboottest.service.AdminUserService;
import org.springframework.stereotype.Service;

/**
 * 后台管理员 Service 实现类
 */
@Service
public class AdminUserServiceImpl extends ServiceImpl<AdminUserMapper, AdminUser>
        implements AdminUserService {

    @Override
    public AdminUser login(String username, String password) {
        QueryWrapper<AdminUser> wrapper = new QueryWrapper<>();
        wrapper.eq("username", username).eq("password", password);
        return getOne(wrapper);
    }
}

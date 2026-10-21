package com.fenglin.springboottest.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.fenglin.springboottest.entity.User;

/**
 * 用户 Service 接口：继承 MyBatis-Plus 的 IService
 */
public interface UserService extends IService<User> {

    /**
     * 注册用户
     * @param user 用户信息
     * @return 注册成功后的用户（含 id）
     */
    User register(User user);

    /**
     * 登录校验
     * @param username 用户名
     * @param password 密码
     * @return 登录成功返回用户，失败返回 null
     */
    User login(String username, String password);
}

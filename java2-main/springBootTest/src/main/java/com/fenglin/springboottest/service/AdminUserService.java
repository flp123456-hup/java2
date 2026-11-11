package com.fenglin.springboottest.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.fenglin.springboottest.entity.AdminUser;

/**
 * 后台管理员 Service 接口
 */
public interface AdminUserService extends IService<AdminUser> {

    /**
     * 管理员登录：按账号 + 密码查询 admin_user 表
     *
     * @return 匹配的管理员对象，未匹配返回 null
     */
    AdminUser login(String username, String password);
}

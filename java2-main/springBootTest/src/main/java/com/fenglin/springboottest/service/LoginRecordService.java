package com.fenglin.springboottest.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.fenglin.springboottest.entity.LoginRecord;

/**
 * 登录记录 Service 接口：继承 MyBatis-Plus 的 IService
 */
public interface LoginRecordService extends IService<LoginRecord> {

    /**
     * 记录一次登录（登录成功时调用）
     * @param username 登录的用户名
     */
    void record(String username);
}

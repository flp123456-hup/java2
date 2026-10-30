package com.fenglin.springboottest.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.fenglin.springboottest.entity.LoginRecord;
import com.fenglin.springboottest.mapper.LoginRecordMapper;
import com.fenglin.springboottest.service.LoginRecordService;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

/**
 * 登录记录 Service 实现类
 */
@Service
public class LoginRecordServiceImpl extends ServiceImpl<LoginRecordMapper, LoginRecord>
        implements LoginRecordService {

    @Override
    public void record(String username) {
        LoginRecord record = new LoginRecord();
        record.setUsername(username);
        record.setLoginTime(LocalDateTime.now());
        record.setCreateTime(LocalDateTime.now());
        this.save(record);
    }
}

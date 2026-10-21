package com.fenglin.springboottest.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fenglin.springboottest.entity.User;
import org.apache.ibatis.annotations.Mapper;

/**
 * 用户 Mapper：继承 MyBatis-Plus 的 BaseMapper，
 * 自动拥有增删改查能力，不用写 SQL
 */
@Mapper
public interface UserMapper extends BaseMapper<User> {
}

package com.fenglin.springboottest.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fenglin.springboottest.entity.AdminUser;
import org.apache.ibatis.annotations.Mapper;

/**
 * 后台管理员 Mapper，继承 BaseMapper 即拥有基础 CRUD
 */
@Mapper
public interface AdminUserMapper extends BaseMapper<AdminUser> {
}

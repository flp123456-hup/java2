package com.fenglin.springboottest.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fenglin.springboottest.entity.Variety;
import org.apache.ibatis.annotations.Mapper;

/**
 * 综艺节目 Mapper：继承 MyBatis-Plus 的 BaseMapper，自动拥有增删改查能力
 */
@Mapper
public interface VarietyMapper extends BaseMapper<Variety> {
}

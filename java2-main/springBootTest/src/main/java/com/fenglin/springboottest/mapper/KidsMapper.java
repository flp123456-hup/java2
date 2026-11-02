package com.fenglin.springboottest.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fenglin.springboottest.entity.Kids;
import org.apache.ibatis.annotations.Mapper;

/**
 * 少儿动画 Mapper：继承 MyBatis-Plus 的 BaseMapper，自动拥有增删改查能力
 */
@Mapper
public interface KidsMapper extends BaseMapper<Kids> {
}

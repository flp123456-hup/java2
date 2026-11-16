package com.fenglin.springboottest.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fenglin.springboottest.entity.Video;
import org.apache.ibatis.annotations.Mapper;

/**
 * 首页短视频 Mapper：继承 MyBatis-Plus 的 BaseMapper，自动拥有增删改查能力
 */
@Mapper
public interface VideoMapper extends BaseMapper<Video> {
}

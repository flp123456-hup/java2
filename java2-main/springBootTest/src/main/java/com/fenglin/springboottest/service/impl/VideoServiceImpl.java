package com.fenglin.springboottest.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.fenglin.springboottest.entity.Video;
import com.fenglin.springboottest.mapper.VideoMapper;
import com.fenglin.springboottest.service.VideoService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 首页短视频 Service 实现类
 */
@Service
public class VideoServiceImpl extends ServiceImpl<VideoMapper, Video> implements VideoService {

    @Override
    public List<Video> listAll() {
        // 按 id 升序返回，保证前端信息流顺序和录入顺序一致
        QueryWrapper<Video> qw = new QueryWrapper<>();
        qw.orderByAsc("id");
        return this.list(qw);
    }
}

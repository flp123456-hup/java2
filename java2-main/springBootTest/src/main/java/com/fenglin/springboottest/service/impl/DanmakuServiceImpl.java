package com.fenglin.springboottest.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.fenglin.springboottest.entity.Danmaku;
import com.fenglin.springboottest.mapper.DanmakuMapper;
import com.fenglin.springboottest.service.DanmakuService;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 弹幕 Service 实现类
 */
@Service
public class DanmakuServiceImpl extends ServiceImpl<DanmakuMapper, Danmaku> implements DanmakuService {

    @Override
    public List<Danmaku> listByVideo(String videoId, Integer episode) {
        QueryWrapper<Danmaku> qw = new QueryWrapper<>();
        qw.eq("video_id", videoId);
        if (episode != null) {
            qw.eq("episode", episode);
        }
        qw.orderByAsc("id");
        return this.list(qw);
    }

    @Override
    public Danmaku add(Danmaku danmaku) {
        if (danmaku.getCreateTime() == null) {
            danmaku.setCreateTime(LocalDateTime.now());
        }
        if (danmaku.getEpisode() == null) {
            danmaku.setEpisode(1);
        }
        this.save(danmaku);
        return danmaku;
    }
}

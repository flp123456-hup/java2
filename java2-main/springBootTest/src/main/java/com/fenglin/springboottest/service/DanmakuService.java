package com.fenglin.springboottest.service;

import com.fenglin.springboottest.entity.Danmaku;

import java.util.List;

/**
 * 弹幕 Service 接口
 */
public interface DanmakuService {

    /** 获取某视频某集的弹幕列表（按发送顺序） */
    List<Danmaku> listByVideo(String videoId, Integer episode);

    /** 保存一条弹幕并返回带 id 的记录 */
    Danmaku add(Danmaku danmaku);
}

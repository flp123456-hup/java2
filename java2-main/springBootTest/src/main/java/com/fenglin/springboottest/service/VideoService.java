package com.fenglin.springboottest.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.fenglin.springboottest.entity.Video;

import java.util.List;

/**
 * 首页短视频 Service 接口：继承 MyBatis-Plus 的 IService
 */
public interface VideoService extends IService<Video> {
    /** 返回全部短视频（按 id 升序，即录入顺序） */
    List<Video> listAll();
}

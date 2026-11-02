package com.fenglin.springboottest.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.fenglin.springboottest.entity.Kids;
import java.util.List;

/**
 * 少儿动画 Service 接口：继承 MyBatis-Plus 的 IService
 */
public interface KidsService extends IService<Kids> {
    /** 按热度/评分排序返回列表，sort=hot|score，order=asc|desc(默认 desc) */
    List<Kids> listSorted(String sort, String order);
}

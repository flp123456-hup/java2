package com.fenglin.springboottest.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.fenglin.springboottest.entity.Drama;
import java.util.List;

/**
 * 电视剧 Service 接口：继承 MyBatis-Plus 的 IService
 */
public interface DramaService extends IService<Drama> {
    /** 按热度/评分排序返回列表，sort=hot|score，order=asc|desc(默认 desc) */
    List<Drama> listSorted(String sort, String order);
}

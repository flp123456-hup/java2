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

    /**
     * 按关键词模糊搜索电视剧：匹配 剧名 / 类型 / 演员 / 标签。
     * keyword 为空或空白时返回全部（等价于 listSorted(hot,desc)）。
     */
    List<Drama> search(String keyword);
}

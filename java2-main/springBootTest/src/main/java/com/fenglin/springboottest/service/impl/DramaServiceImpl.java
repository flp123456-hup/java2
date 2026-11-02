package com.fenglin.springboottest.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.fenglin.springboottest.entity.Drama;
import com.fenglin.springboottest.mapper.DramaMapper;
import com.fenglin.springboottest.service.DramaService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 电视剧 Service 实现类
 */
@Service
public class DramaServiceImpl extends ServiceImpl<DramaMapper, Drama> implements DramaService {
    @Override
    public List<Drama> listSorted(String sort, String order) {
        QueryWrapper<Drama> qw = new QueryWrapper<>();
        // 仅允许 hot / score 两个白名单字段，避免 SQL 注入
        String field = "score".equalsIgnoreCase(sort) ? "score" : "hot";
        if ("asc".equalsIgnoreCase(order)) {
            qw.orderByAsc(field);
        } else {
            qw.orderByDesc(field);
        }
        return this.list(qw);
    }
}

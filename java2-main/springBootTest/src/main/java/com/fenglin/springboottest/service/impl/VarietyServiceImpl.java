package com.fenglin.springboottest.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.fenglin.springboottest.entity.Variety;
import com.fenglin.springboottest.mapper.VarietyMapper;
import com.fenglin.springboottest.service.VarietyService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 综艺 Service 实现类
 */
@Service
public class VarietyServiceImpl extends ServiceImpl<VarietyMapper, Variety> implements VarietyService {
    @Override
    public List<Variety> listSorted(String sort, String order) {
        QueryWrapper<Variety> qw = new QueryWrapper<>();
        String field = "score".equalsIgnoreCase(sort) ? "score" : "hot";
        if ("asc".equalsIgnoreCase(order)) {
            qw.orderByAsc(field);
        } else {
            qw.orderByDesc(field);
        }
        return this.list(qw);
    }
}

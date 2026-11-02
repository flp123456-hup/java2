package com.fenglin.springboottest.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.fenglin.springboottest.entity.Kids;
import com.fenglin.springboottest.mapper.KidsMapper;
import com.fenglin.springboottest.service.KidsService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 少儿动画 Service 实现类
 */
@Service
public class KidsServiceImpl extends ServiceImpl<KidsMapper, Kids> implements KidsService {
    @Override
    public List<Kids> listSorted(String sort, String order) {
        QueryWrapper<Kids> qw = new QueryWrapper<>();
        String field = "score".equalsIgnoreCase(sort) ? "score" : "hot";
        if ("asc".equalsIgnoreCase(order)) {
            qw.orderByAsc(field);
        } else {
            qw.orderByDesc(field);
        }
        return this.list(qw);
    }
}

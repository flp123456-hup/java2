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

    @Override
    public List<Drama> search(String keyword) {
        // 关键词为空：返回全部（按热度倒序），保证搜索页/下拉有内容
        if (keyword == null || keyword.trim().isEmpty()) {
            return listSorted("hot", "desc");
        }
        String kw = keyword.trim();
        QueryWrapper<Drama> qw = new QueryWrapper<>();
        // 在 剧名 / 类型 / 演员 / 标签 四个字段上做模糊匹配（OR 关系）
        qw.like("title", kw)
          .or().like("genres", kw)
          .or().like("cast", kw)
          .or().like("status", kw);
        qw.orderByDesc("hot");
        return this.list(qw);
    }
}

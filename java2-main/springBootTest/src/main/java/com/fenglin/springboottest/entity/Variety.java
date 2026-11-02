package com.fenglin.springboottest.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 综艺节目实体，对应数据库表 variety
 */
@Data
@TableName("variety")
public class Variety {

    /** 主键 id，自增 */
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 节目名 */
    private String title;

    /** 类型，逗号分隔，如 综艺,真人秀 */
    private String genres;

    /** 首播年份 */
    private Integer year;

    /** 评分 0.0~10.0 */
    private BigDecimal score;

    /** 热度值 */
    private Integer hot;

    /** 期数/季数描述，如 第1-2季 / 已完结 */
    private String episodes;

    /** 标签：热播 / 独家 / 经典 / 治愈 */
    private String status;

    /** 封面表情 */
    private String emoji;

    /** 封面渐变色 CSS */
    private String gradient;

    /** 简介 */
    private String description;

    /** 嘉宾资料(JSON 字符串) */
    private String cast;

    /** 录入时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
}

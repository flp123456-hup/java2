package com.fenglin.springboottest.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 弹幕实体，对应数据库表 danmaku
 * 说明：videoId 存的是前端 media.id（如 d7 / fp1 / 长月烬明 等），保证不同剧/集的弹幕互不串台。
 */
@Data
@TableName("danmaku")
public class Danmaku {

    /** 主键 id，自增 */
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 视频/剧集标识（前端 media.id） */
    @TableField("video_id")
    private String videoId;

    /** 集数 */
    private Integer episode;

    /** 弹幕文本 */
    private String content;

    /** 颜色（CSS 颜色字符串），如 #ffffff */
    private String color;

    /** 出现时间点（秒），可选 */
    @TableField("play_time")
    private Double playTime;

    /** 发送时间 */
    @TableField("create_time")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
}
